import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget cartProductTile(int index, onProductDelete) {
  return Consumer<CartViewModel>(
    builder: (contex, model, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 63.w,
                      height: 63.h,
                      color: Color(0xFFE3E3E3),
                      child: Center(
                          child: FadeInImage.assetNetwork(
                        placeholder: productPlaceHolder,
                        image:
                            '${model.authService.order.products![index].images![0]}',
                        fit: BoxFit.fill,
                        width: 63.w,
                        height: 63.h,
                      )),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${model.authService.order.products![index].name}',
                            style: boldTextStyleLato.copyWith(
                                fontSize: 14.sp, fontFamily: latoFont)),
                        SizedBox(height: 3.h),
                        SizedBox(height: 3.h),
                        Text(
                            '€ ${model.authService.order.products![index].salePrice ?? model.authService.order.products![index].price}',
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: primaryColor,
                                fontFamily: latoFont)),
                        SizedBox(height: 3.h),
                        model.authService.order.products![index].sizes != null
                            ? Container(
                                height: 15.h,
                                child: ListView.builder(
                                    itemCount: model.authService.order
                                        .products![index].sizes!.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Text(
                                          '${model.authService.order.products![index].sizes![i].size} (${model.authService.order.products![index].sizes![i].count})',
                                          overflow: TextOverflow.ellipsis,
                                          style: boldTextStyleLato.copyWith(
                                              fontSize: 10.sp,
                                              color: Color(0xFF58595B)),
                                        ),
                                      );
                                    }))
                            : Container(
                                child: Text('', style: bodyTextStyleLato)),
                      ],
                    ),
                  ],
                ),
                // Center(
                //   child: IconButton(
                //     padding: EdgeInsets.zero,
                //     onPressed: onProductDelete,
                //     icon: Icon(
                //       Icons.delete,
                //       color: primaryColor,
                //       size: 35,
                //     ),
                //   ),
                // )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    constraints: BoxConstraints(maxHeight: 30),
                    icon: Container(
                      height: 17.h,
                      width: 17.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Center(
                          child: ImageContainer(
                        assetImage: '$staticAssets/plus-icon.png',
                        width: 8.w,
                        height: 8.h,
                      )),
                    ),
                    onPressed: () {
                      model.incrementProducts(
                          model.authService.order.products![index],
                          model.authService.order);
                    }),
                Text(
                  '${model.authService.order.products![index].count ?? '1'}',
                  style: boldTextStyleHacen.copyWith(
                      fontSize: 14.sp, color: blackColor),
                ),
                IconButton(
                  constraints: BoxConstraints(maxHeight: 30),
                  icon: Container(
                    height: 17.h,
                    width: 17.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: Center(
                        child: ImageContainer(
                      assetImage: '$staticAssets/minus-icon.png',
                      width: 6.w,
                      height: 6.h,
                    )),
                  ),
                  onPressed: () {
                    model.decrementProducts(
                        model.authService.order.products![index],
                        model.authService.order);
                  },
                ),
              ],
            ),
            Divider(color: Color(0xFF58595B)),
            SizedBox(height: 6.h)
          ],
        ),
      );
    },
  );
}
