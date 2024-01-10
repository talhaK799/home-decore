import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsContainer extends StatefulWidget {
  final onChange;
  final Product? product;
  final salePrice;

  ProductsContainer({this.onChange, this.product, this.salePrice});

  @override
  _ProductsContainerState createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: widget.product!.isDiscountAvailable!
          ? BorderRadius.circular(10)
          : BorderRadius.circular(10),
      shadowColor: widget.product!.isDiscountAvailable!
          ? lightGreyColor
          : lightGreyColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 3.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.h),
              // width: 153.w,
              // height: 225.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: lightGreyColor,
                //     spreadRadius: 2,
                //     blurRadius: 3,
                //     offset: Offset(0, 5),
                //   ),
                // ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 140.w,
                      height: 115.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Color(0xFFE3E3E3),
                      ),
                      child: Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: FadeInImage.assetNetwork(
                          placeholder: '$productPlaceHolder',
                          image: '${widget.product!.images![0]}',
                          fit: BoxFit.cover,
                          width: 140.w,
                          height: 115.h,
                        ),
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.6.h),
                  Flexible(
                    child: Text(
                      '${widget.product!.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: boldTextStyleLato.copyWith(
                          color: blackColor,
                          fontFamily: latoFont,
                          fontSize: 14),
                    ),
                  ),

                  // Flexible(
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'By: ',
                  //         style: boldTextStyleLato.copyWith(
                  //             fontSize: 13.sp, color: Color(0xFF58595B)),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           '${widget.product!.category ?? " "}',
                  //           overflow: TextOverflow.ellipsis,
                  //           // "Nike",
                  //           style: boldTextStyleLato.copyWith(
                  //               decoration: TextDecoration.underline,
                  //               fontSize: 13.sp,
                  //               color: Color(0xFF58595B)),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              widget.product!.isDiscountAvailable!
                                  ? Text(
                                      '€ ${widget.product!.price ?? 00.toStringAsFixed(2)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: boldTextStyleHacen.copyWith(
                                          fontSize: 7.sp,
                                          color: Color(0xFF58595B),
                                          fontFamily: latoFont,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : Container(),
                              Flexible(
                                child: Text(
                                  widget.salePrice != null
                                      ? '€ ${widget.salePrice ?? 00.toStringAsFixed(2)}'
                                      : '€ ${widget.product!.salePrice ?? 00.toStringAsFixed(2)}',
                                  overflow: TextOverflow.ellipsis,
                                  style: boldTextStyleHacen.copyWith(
                                      fontSize: 12.sp,
                                      fontFamily: latoFont,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: widget.onChange,
                          child: widget.product!.isLiked == true
                              ? Icon(
                                  Icons.favorite,
                                  color: primaryColor,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: blackColor,
                                ),
                        )
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
                  left: 100.w,
                  top: 20.h,
                  child: Container(
                    width: 53.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(2),
                      color: Color(0xFFFF4545),
                    ),
                    child: Center(
                      child: Text('${widget.product!.discountPercentage}% OFF',
                          style: buttonTextStyle.copyWith(
                              fontSize: 8.sp, fontFamily: latoFont)),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }
}
