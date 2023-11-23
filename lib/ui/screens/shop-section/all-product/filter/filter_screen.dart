import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/authentication_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  final List<Product>? products;
  FilterScreen({this.products});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsViewModel(),
      child: Consumer<ProductsViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                SizedBox(height: 10.h),

                ///
                /// custom app bar
                ///
                AuthenticationAppBar(
                  leadingIcon: '$staticAssets/cancel_icon.png',
                  color: primaryColor,
                  onBack: () => Get.back(),
                  heading: "Sort Products".tr,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(color: greyColor.withOpacity(0.5)),
                      SizedBox(height: 20.h),

                      ///
                      /// Sort by ..... [different types]
                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sortingMaterials(
                            '$staticAssets/new_arrivals.png',
                            'new_arrival'.tr,
                            onTap: () => model.updateSorting("1"),
                            isSelected: model.sorting == "1" ? true : false,
                          ),
                          sortingMaterials(
                            '$staticAssets/low_to_high.png',
                            'low_to_high'.tr,
                            onTap: () => model.updateSorting("2"),
                            isSelected: model.sorting == "2" ? true : false,
                          ),
                          sortingMaterials(
                            '$staticAssets/high_to_low.png',
                            'high_to_low'.tr,
                            onTap: () => model.updateSorting("3"),
                            isSelected: model.sorting == "3" ? true : false,
                          ),
                          sortingMaterials(
                            '$staticAssets/top_rated.png',
                            'Categories'.tr,
                            onTap: () => model.updateSorting("4"),
                            isSelected: model.sorting == "4" ? true : false,
                          ),
                        ],
                      ),
                      SizedBox(height: 60.h),

                      ///
                      /// Button
                      ///
                      Container(
                        height: 40.h,
                        child: RectangularButton(
                          onTap: () {
                            model.applySorting(products: products ?? null);
                          },
                          radius: 10,
                          title: 'apply'.tr,
                          width: 113.w,
                          buttonColor: primaryColor,
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget sortingMaterials(String image, String title,
      {isSelected = false, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            '$image',
            height: 23.5.h,
            width: 23.5.w,
            color: isSelected ? primaryColor : greyColor,
          ),
          SizedBox(height: 8.h),
          Text('$title',
              style: normalTextStyleLato.copyWith(
                fontSize: 8.sp,
                color: isSelected ? primaryColor : greyColor,
              ))
        ],
      ),
    );
  }
}
