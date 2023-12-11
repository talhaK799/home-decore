import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/categories.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/ui/custom_widgets/app_banners_slider.dart';
import 'package:f2_base_project/ui/custom_widgets/home_prod_container.dart';
import 'package:f2_base_project/ui/custom_widgets/prod_shimmer.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/all_categories_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_screen.dart';
import 'package:f2_base_project/ui/screens/home/home_view_model.dart';
import 'package:f2_base_project/ui/screens/new_in_products/new_arrival_screen.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  bool isDrawerOpened = false;
  toggleAnimation() {
    if (animationController!.isDismissed) {
      isDrawerOpened = true;
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              backgroundColor: primaryColor,
              key: model.scaffoldKey,
              body: ListView(
                // physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: primaryColor,
                    height: 84.h,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 30.h, 12.w, 0.h),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Image.asset(
                                    '$staticAssets/drawer_icon.png',
                                    height: 20.h,
                                    width: 25.w),
                                onPressed: () {
                                  print('open drawer');
                                  toggleAnimation();
                                  advancedDrawerController.showDrawer();
                                  advancedDrawerController.value =
                                      AdvancedDrawerValue.visible();
                                  if (advancedDrawerController.value.visible ==
                                      false) {
                                    advancedDrawerController.showDrawer();
                                    setState(() {});
                                  }
                                },
                              ),
                              SizedBox(width: 7.w),
                              Text(
                                'Inna Home'.tr,
                                style: normalTextStyleLato,
                              )
                            ],
                          ),
                          Spacer(),

                          ///
                          ///
                          ///Removed search bar according to new design
                          ///
                          // SizedBox(width: 15.w),
                          // Expanded(
                          //   child: Container(
                          //     height: 30.h,
                          //     // width: 0.35.sw,
                          //     decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(10)),
                          //     child: TextField(
                          //       textInputAction: TextInputAction.search,
                          //       onSubmitted: (value) {
                          //         model.searchByName(value);
                          //       },
                          //       onChanged: (value) {
                          //         model.searchByName(value);
                          //       },
                          //       decoration: InputDecoration(
                          //           suffixIcon: UnconstrainedBox(
                          //             child: ImageContainer(
                          //                 height: 16.h,
                          //                 width: 16.w,
                          //                 assetImage:
                          //                     '$staticAssets/search.png'),
                          //           ),
                          //           contentPadding:
                          //               EdgeInsets.only(left: 13, bottom: 17),
                          //           border: InputBorder.none,
                          //           hintText: 'Search products'.tr,
                          //           hintStyle: normalTextStyleLato.copyWith(
                          //               fontSize: 13.sp,
                          //               color: Color(0xFFCFCFCF))),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 11.w),
                          IconButton(
                            constraints: BoxConstraints(maxHeight: 23),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (model.authService.isLogin) {
                                Get.to(() => CartScreen());
                              } else {
                                Get.dialog(SignupRequiredDialog('rootScreen'));
                              }
                            },
                            icon: model.authService.order.products == null
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
                          )
                        ],
                      ),
                    ),
                  ),

                  ///
                  /// Custom App Bar with icons and title
                  ///
                  // customAppBar(model),
                  Stack(
                    children: [
                      // image Slider
                      AppBannersSlider(
                        image: model.authService.banners,
                        height: 250.h,
                        isCover: true,
                      ),
                      Column(
                        children: [
                          SizedBox(height: 220.h),
                          Container(
                            padding: EdgeInsetsDirectional.only(start: 20.w),
                            decoration: topRoundedDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25.h),

                                ///
                                /// categories
                                ///
                                // Padding(
                                //   padding:
                                //       EdgeInsetsDirectional.only(start: 8.0),
                                //   child: Text(
                                //     'Categories'.tr,
                                //     style: normalTextStyleLato.copyWith(
                                //         fontSize: 18.sp, color: blackColor),
                                //   ),
                                // ),
                                customViewAllRow(
                                    'Categories',
                                    () => Get.to(() => AllCategoriesScreen(
                                        title: 'Categories',
                                        newInProductsList:
                                            model.authService.categories))),
                                SizedBox(height: 12.h),
                                Container(
                                  height: 170.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        model.authService.categories.length,
                                    itemBuilder: (context, index) {
                                      return categories(
                                          model.authService.categories, index);
                                    },
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),

                                /// =========================================================
                                /// New Arrivals
                                ///
                                customViewAllRow(
                                    'New Arrivals',
                                    () => Get.to(() => NewArrivalScreen(
                                        title: 'New In',
                                        newInProductsList:
                                            model.authService.latestProducts))),
                                SizedBox(height: 8.h),

                                Container(
                                  height: 190.h,
                                  child:

                                      ///
                                      /// Show shimmer effect until products loaded successfully
                                      ///
                                      model.isShimmer
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                return ProdShimmer(
                                                    width: 153.w,
                                                    height: 200.h,
                                                    radius: 10.0);
                                              })
                                          : model.searchedProducts.isEmpty
                                              ? newInProductsList(
                                                  model,
                                                  model.authService
                                                      .latestProducts)
                                              : newInProductsList(model,
                                                  model.searchedProducts),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),

                                /// ============================================
                                /// Top Rated products
                                ///
                                customViewAllRow(
                                    'Top Rated Products',
                                    () => Get.to(() => NewArrivalScreen(
                                        title: 'Top Rated',
                                        newInProductsList: model
                                            .authService.topRatedProducts))),

                                SizedBox(height: 8.h),

                                Container(
                                  height: 190.h,
                                  child:

                                      ///
                                      /// Show shimmer effect until products loaded successfully
                                      ///
                                      model.isShimmer
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                return ProdShimmer(
                                                    width: 153.w,
                                                    height: 200.h,
                                                    radius: 10.0);
                                              })
                                          : newInProductsList(
                                              model,
                                              model.authService
                                                  .topRatedProducts),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),

                                /// =========================================================
                                ///
                                /// All Products
                                ///

                                customViewAllRow(
                                    'All Products',
                                    () => Get.offAll(
                                        () => RootScreen(selectedPage: 1))),

                                SizedBox(height: 8.h),
                                Container(
                                  height: 190.h,
                                  child:

                                      ///
                                      /// Show shimmer effect until products loaded successfully
                                      ///
                                      model.isShimmer
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                return ProdShimmer(
                                                    width: 153.w,
                                                    height: 200.h,
                                                    radius: 10.0);
                                              })
                                          : newInProductsList(model,
                                              model.authService.allProducts),
                                ),
                                SizedBox(height: 25.h),

                                Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 10.0, bottom: 10),
                                    child: Text('Offers',
                                        style: normalTextStyleLato.copyWith(
                                            fontSize: 18.sp,
                                            color: blackColor))),

////removed offerslider
                                ///
                                // ///
                                // /// offer images
                                // ///
                                // Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 15.0),
                                //     child: OffersSlider(
                                //         offers: model.authService.offers,
                                //         images: model.offersImages,
                                //         model: model)),

                                // SizedBox(height: 100.h),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  customViewAllRow(String title, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10.0),
            child: Text(
              title,
              style: boldTextStyleLato.copyWith(
                  fontSize: 18.sp, color: blackColor),
            ),
          ),
          Row(
            children: [
              Text(
                'view_all'.tr,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 15.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(width: 20.w)
            ],
          )
        ],
      ),
    );
  }

  Widget newInProductsList(HomeViewModel model, List<Product> products) {
    return products.isEmpty
        ? Center(child: Text('searched_prod_not_found'.tr))
        : ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  model.authService.order.products =
                      await Get.to(() => ProductDetailScreen(
                                isFirstTime: true,
                                product: products[index],
                              )) ??
                          model.authService.order.products;
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 0.w, bottom: 10.h, end: 16),
                  child: HomeProdContainer(
                    onChange: () {
                      model.toggleProductLike(products, index);
                    },
                    product: products[index],
                  ),
                ),
              );
            },
          );
  }

  Widget categories(List<Categories> services, int index) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            Get.to(() =>
                SubCategoryScreen(services[index].title!, services[index].id!));
          },

          child: Container(
            // height: 120.h,
            width: 135.w,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 0),
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: Column(
                children: [
                  services[index].iconUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${services[index].iconUrl}',
                            width: 130.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 70.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Flexible(
                    child: Text(
                      '${services[index].title ?? ''}',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyleHacen.copyWith(
                          fontSize: 14.sp,
                          color: blackColor,
                          fontFamily: latoFont,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          // child: UnconstrainedBox(
          //   child: Container(
          //     height: 70.2.h,
          //     width: 86.8.w,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       color: primaryColor,
          //     ),
          //     child: Stack(
          //       children: [
          //         Align(
          //           alignment: Alignment.bottomRight,
          //           // child:
          //           //     // services[index].imageUrl != null
          //           //     //     ? FadeInImage.assetNetwork(
          //           //     //         placeholder:
          //           //     //             '$staticAssets/service-sport-background.png',
          //           //     //         image: '${services[index].imageUrl}',
          //           //     //         fit: BoxFit.contain,
          //           //     //       )
          //           //     //     :
          //           //     Image.network(
          //           //   '${services[index].iconUrl}',
          //           //   width: 77.7.w,
          //           //   height: 71.9.h,
          //           //   fit: BoxFit.cover,
          //           //   // color: Color(0xFFDA4646),
          //           // ),
          //         ),
          //         Positioned(
          //           top: 8.h,
          //           left: 6.w,
          //           right: 5.w,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               services[index].iconUrl != null
          //                   ? Image.network('${services[index].iconUrl}',
          //                       width: 37.w, height: 35.h, color: Colors.white)
          //                   : Container(),
          //               SizedBox(height: 4.h),
          //               Text('${services[index].title}',
          //                   style: bodyTextStyleLato.copyWith(
          //                       color: Colors.white, fontSize: 15.sp))
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }
}
