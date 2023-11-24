import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProdContainer extends StatefulWidget {
  final onChange;
  final Product? product;

  HomeProdContainer({this.onChange, this.product});

  @override
  _ProductsContainerState createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<HomeProdContainer> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10),
      shadowColor: lightGreyColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 3.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 11.h),
              width: 153.w,
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
                  Container(
                    width: 117.w,
                    height: 103.h,
                    color: Color(0xFFE3E3E3),
                    child: Center(
                        child: FadeInImage.assetNetwork(
                      placeholder: '$productPlaceHolder',
                      image: '${widget.product!.images![0]}',
                      fit: BoxFit.contain,
                      width: 117.w,
                      height: 103.h,
                    )),
                  ),
                  SizedBox(height: 7.6.h),
                  Flexible(
                    child: Text(
                      '${widget.product!.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: boldTextStyleLato.copyWith(
                          fontFamily: latoFont, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 2.7.h),
                  Flexible(
                    child: Row(
                      children: [
                        Text(
                          'By: ',
                          style: boldTextStyleLato.copyWith(
                              fontSize: 13.sp, color: Color(0xFF58595B)),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.product!.category ?? " "}',
                            overflow: TextOverflow.ellipsis,
                            // "Nike",
                            style: boldTextStyleLato.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 13.sp,
                                color: Color(0xFF58595B)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9.8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            widget.product!.isDiscountAvailable == true
                                ? Text(
                                    'BDT ${widget.product!.price ?? 00.toStringAsFixed(2)}',
                                    overflow: TextOverflow.ellipsis,
                                    style: boldTextStyleHacen.copyWith(
                                        fontSize: 7.sp,
                                        color: Color(0xFF58595B),
                                        fontFamily: latoFont,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                : Container(),
                            Flexible(
                              child: Text(
                                'BDT ${widget.product!.salePrice ?? 00.toStringAsFixed(2)}',
                                overflow: TextOverflow.ellipsis,
                                style: boldTextStyleHacen.copyWith(
                                    fontSize: 12.sp,
                                    fontFamily: latoFont,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: widget.onChange,
                        child: ImageContainer(
                          height: 15.2.h,
                          width: 16.4.w,
                          assetImage: widget.product!.isLiked ?? false
                              ? '$staticAssets/like.png'
                              : '$staticAssets/dislike.png',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          ///
          /// Percent off banner
          ///
          widget.product!.isDiscountAvailable == true
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
