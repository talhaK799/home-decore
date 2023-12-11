import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/full_screen_image.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/custom_widgets/sliding_indication_dots.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {
  Product? product;
  bool? isFromOffer;
  Offers? offer;
  bool? isFirstTime;
  ProductDetailScreen(
      {this.product,
      this.isFromOffer = false,
      this.offer,
      this.isFirstTime = false});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDetailProvider(
          widget.product!,
          widget.isFromOffer!,
          widget.offer ?? Offers(),
          widget.isFirstTime ?? false),
      child: Consumer<ProductDetailProvider>(
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () => model.onBackPress(widget.product),
            child: ModalProgressHUD(
              progressIndicator: circularProgressIndicator(),
              inAsyncCall: model.state == ViewState.busy,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(children: [
                      ///
                      /// Sliding Images
                      ///
                      ImageSlider(
                          images: widget.product!.images!,
                          model: model,
                          product: widget.product),

                      ///
                      /// Product other details
                      ///
                      Padding(
                          padding: EdgeInsets.only(top: 371.h),
                          child: Container(
                              decoration: topRoundedDecoration,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 31, start: 24, end: 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ///
                                          /// Prodcut Details [Name, Price Rating etc]
                                          ///
                                          productDetail(model),

                                          ///
                                          /// Add to cart Button And Favourite Icon
                                          ///
                                          bottomButtons(model, widget.product!),
                                          SizedBox(height: 30.h),
                                        ],
                                      ),
                                    ),
                                  ])))
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bottomButtons(ProductDetailProvider model, Product product) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 15),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Expanded(
            child: RectangularButton(
              onTap: () {
                if (widget.product!.stock != 0) {
                  model.addToCart(widget.product!);
                }
              },
              buttonColor:
                  widget.product!.stock == 0 ? greyColor : primaryColor,
              textStyle: bodyTextStyleLato.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              radius: 9.0,
              title: widget.product!.stock == 0
                  ? 'out_of_stock'.tr
                  : 'add_to_cart'.tr,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: RectangularButton(
              onTap: () async {
                if (model.authService.isLogin) {
                  if (widget.product!.stock != 0) {
                    model.addToCart(widget.product!, isShowSnackbar: false);
                    model.authService.order.products =
                        await Get.to(() => CartScreen()) ??
                            model.authService.order.products;
                    model.setState(ViewState.idle);
                  } else {
                    Get.snackbar('Out of stock', 'Product out of stock',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  Get.dialog(SignupRequiredDialog('rootScreen'));
                }
              },
              buttonColor:
                  widget.product!.stock == 0 ? greyColor : primaryColor,
              textStyle: bodyTextStyleLato.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              radius: 9.0,
              title:
                  widget.product!.stock == 0 ? 'out_of_stock'.tr : 'Buy Now'.tr,
            ),
          ),
        ],
      ),
    );
  }

  Widget productDetail(ProductDetailProvider model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.6.w, end: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.product!.name}',
            style: boldTextStyleHacen.copyWith(
                color: Colors.black, fontSize: 32.sp, fontFamily: latoFont),
          ),
          SizedBox(height: 7.5.h),
          // Row(
          //   children: [
          //     widget.product!.isDiscountAvailable == true
          //         ? Text(
          //             'BDT ${model.price}',
          //             style: boldTextStyleHacen.copyWith(
          //                 fontSize: 11.sp,
          //                 color: Color(0xFF58595B),
          //                 fontFamily: latoFont,
          //                 decoration: TextDecoration.lineThrough),
          //           )
          //         : Container(),
          //     SizedBox(width: 7.w),
          //     Text(
          //       'BDT ${model.salePrice}',
          //       style: boldTextStyleHacen.copyWith(
          //           fontSize: 14.sp, color: primaryColor, fontFamily: latoFont),
          //     ),
          //     SizedBox(width: 7.w),
          //     widget.product!.productSizes.length > 0
          //         ? Expanded(
          //             child: Row(
          //               children: [
          //                 Text(
          //                   'Sizes:  ',
          //                   style: boldTextStyleHacen.copyWith(
          //                       fontSize: 14.sp,
          //                       color: primaryColor,
          //                       fontFamily: latoFont),
          //                 ),
          //                 Container(
          //                   decoration: BoxDecoration(
          //                       // color: primaryColor,
          //                       border: Border.all(
          //                           color: greyColor.withOpacity(0.5)),
          //                       borderRadius: BorderRadius.circular(6)),
          //                   child: DropdownButtonHideUnderline(
          //                     child: DropdownButton<String>(
          //                       value: model.selectedSize,
          //                       elevation: 2,
          //                       borderRadius: BorderRadius.circular(6),
          //                       focusColor: primaryColor,
          //                       onChanged: (String? newValue) {
          //                         for (int i = 0;
          //                             i < widget.product!.productSizes.length;
          //                             i++) {
          //                           if (newValue ==
          //                               widget.product!.productSizes[i].size) {
          //                             model.selectedSizeIndex = i;
          //                           }
          //                         }
          //                         model.changeSize(
          //                             widget.product!, model.selectedSizeIndex,
          //                             isFromOffer: widget.isFromOffer,
          //                             offer: widget.offer);
          //                         setState(() {
          //                           model.selectedSize = newValue!;
          //                         });
          //                       },
          //                       items: widget.product!.productSizes
          //                           .map((ProductSizes value) {
          //                         return DropdownMenuItem<String>(
          //                           value: value.size,
          //                           child: Text(
          //                             '${value.size}',
          //                             style: bodyTextStyleLato,
          //                           ),
          //                         );
          //                       }).toList(),
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           )
          //         : Container(),
          //     SizedBox(width: 7.w),
          //   ],
          // ),

          SizedBox(height: 5.h),
          Text('${widget.product!.description ?? ''}',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF8A8A8A),
                  fontFamily: latoFont)),
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '€ ${widget.product!.price}',
                style: headingTextStyleLato.copyWith(color: primaryColor),
              ),
              InkWell(
                onTap: () {
                  model.toggleProductLike(widget.product!);
                },
                child: widget.product!.isLiked ?? false
                    ? Icon(Icons.favorite, color: primaryColor, size: 25.h)
                    : Icon(Icons.favorite_border,
                        color: primaryColor, size: 25.h),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(color: Color(0xFF808080), height: 0.13.h),
          ),

          ///
          /// Related products
          ///
          model.relatedProducts.isEmpty
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Related Products',
                        style: headingTextStyleLato.copyWith(
                            color: blackColor, fontSize: 15.sp)),
                    SizedBox(height: 9),
                    Container(
                        height: 120.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.relatedProducts.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: relatedProducts(model, index),
                              );
                            })),
                  ],
                ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  //

  Widget relatedProducts(ProductDetailProvider model, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                        product: model.relatedProducts[index],
                        isFromOffer: widget.isFromOffer,
                        offer: widget.offer)));
          },
          child: Container(
              width: 90.w,
              height: 80.h,
              color: Color(0xFFE3E3E3),
              child: Stack(
                children: [
                  Center(
                      child: FadeInImage.assetNetwork(
                    placeholder: '$productPlaceHolder',
                    image: '${model.relatedProducts[index].images![0]}',
                    fit: BoxFit.contain,
                    width: 120.w,
                    height: 120.h,
                  )),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite,
                        color: model.relatedProducts[index].isLiked ?? false
                            ? primaryColor
                            : greyColor,
                        size: 14.h,
                      ),
                    ),
                  ),
                  model.relatedProducts[index].isDiscountAvailable == true
                      ? Positioned(
                          top: 13.5.h,
                          child: Container(
                            color: primaryColor,
                            width: 44.9.w,
                            height: 15.6.h,
                            child: Center(
                              child: Text(
                                '${model.relatedProducts[index].discountPercentage}% ' +
                                    'off'.tr,
                                style: boldTextStyleHacen.copyWith(
                                    fontSize: 10.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Text(
              '${model.relatedProducts[index].name}',
              style: boldTextStyleLato.copyWith(
                  color: blackColor, fontSize: 13.sp, fontFamily: latoFont),
            ),
            // widget.product!.isDiscountAvailable == true
            //     ? Text(
            //         'BDT ${model.price}',
            //         style: boldTextStyleHacen.copyWith(
            //             fontSize: 11.sp,
            //             color: Color(0xFF58595B),
            //             fontFamily: latoFont,
            //             decoration: TextDecoration.lineThrough),
            //       )
            //     : Container(),
            // SizedBox(width: 7.w),
            // Text(
            //   'BDT ${model.salePrice}',
            //   style: boldTextStyleHacen.copyWith(
            //       fontSize: 13.sp, fontFamily: latoFont),
            // ),
          ],
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ImageSlider extends StatefulWidget {
  final List<String> images;
  final ProductDetailProvider? model;
  Product? product;
  ImageSlider({required this.images, this.model, this.product});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 447.h,
          child: PageView.builder(
              controller: widget.model!.pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              onPageChanged: (int index) {
                setState(() {
                  widget.model!.currentImage = index;
                });
              },
              itemBuilder: (context, index) {
                return FadeInImage.assetNetwork(
                  placeholder: '$productPlaceHolder',
                  image: '${widget.images[index]}',
                  fit: BoxFit.cover,
                );
              }),
        ),

        ///
        /// Indication Dots
        ///
        Positioned(
          top: 330.h,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 45.w),
                Container(
                    height: 20.h,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return SlidingIndicationDots(
                            index: index,
                            currentImage: widget.model!.currentImage,
                            height: 12.03,
                            width: 12.03,
                            // fillColor: primaryColor,
                          );
                        })),
                // Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.to(() => FullScreenImage(
                                imageUrl:
                                    widget.images[widget.model!.currentImage]));
                          },
                          child: Icon(Icons.fullscreen,
                              color: Colors.white, size: 25.r)),
                      SizedBox(width: 10.w)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        ///
        /// Percent off banner
        ///
        widget.product!.isDiscountAvailable!
            ? Positioned(
                top: 130.h,
                child: Container(
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90.9.w,
                        height: 36.1.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4)),
                          color: Color(0xFFFF4545),
                        ),
                        child: Center(
                          child: Text(
                              '${widget.product!.discountPercentage}% OFF',
                              style: buttonTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  fontFamily: latoFont)),
                        ),
                      ),
                    ],
                  ),
                ))
            : Container(),

        ///
        /// Back, Share and Cart Icons
        ///
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Transform(
                            alignment: Alignment.center,
                            transform: Get.locale!.languageCode == 'ar'
                                ? Matrix4.rotationY(pi)
                                : Matrix4.rotationY(0),
                            child: Image.asset('$staticAssets/back.png',
                                color: primaryColor,
                                height: 22.h,
                                width: 11.w)),
                        onPressed: () => Get.back()),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        icon: widget.model!.authService.order.products == null
                            ? Image.asset(
                                '$staticAssets/no-item-cart.png',
                                width: 21.06.w,
                                height: 21.16.h,
                              )
                            : Image.asset(
                                '$staticAssets/cart-with-items1.png',
                                width: 21.06.w,
                                height: 21.16.h,
                              ),
                        onPressed: () async {
                          if (widget.model!.authService.isLogin) {
                            widget.model!.authService.order.products =
                                await Get.to(() => CartScreen()) ??
                                    widget.model!.authService.order.products;
                            setState(() {});
                          } else {
                            Get.dialog(SignupRequiredDialog('rootScreen'));
                          }
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 22.h,
                        ),
                        onPressed: () {
                          Share.share(
                              '${widget.images[0]}\n${widget.product!.name}\n${widget.product!.description}\n${widget.product!.salePrice}');
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
