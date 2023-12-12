import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/custom_widgets/sub_category_container.dart';
import 'package:f2_base_project/ui/screens/home/category_products/categ_prod_view_model.dart';
import 'package:f2_base_project/ui/screens/home/category_products/category_product_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_viewmodel.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SubCategoryScreen extends StatelessWidget {
  String category;

  String categoryId;
  SubCategoryScreen(
    this.category,
    this.categoryId,
  );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => SubCategoryViewModel(category, categoryId),
      child: Consumer<SubCategoryViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: BaseScreen(
                // bottomNavBar: BottomNavBar(4),
                topPadding: 91,

                ///
                /// custom App Bar
                ///
                appBarChild: CustomAppBar(
                  leadingIcon: '$staticAssets/back_icon.png',
                  // title: '$category',
                  title: '$category',
                ),

                ///
                /// New Arrivals List
                ///
                body: Container(
                  alignment: Alignment.center,
                  decoration: topRoundedDecoration,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            model.subCategory.isEmpty
                                ? Center(
                                    child: Text(
                                        'Subcategory not found'
                                            ))
                                : Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                              primary: false,
                                              itemCount:
                                                  model.subCategory.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                               gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                             childAspectRatio: Get.height >= 800
                                                ? MediaQuery.of(context).size.width /
                                                    (MediaQuery.of(context).size.height / 1.75)
                                                : MediaQuery.of(context).size.width /
                                                    (MediaQuery.of(context).size.height / 1.6),
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 4,
                                                      crossAxisSpacing: 4),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0,
                                                          left: 3,
                                                          right: 3),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // Get.to(CategProdScreen());
                                                    },
                                                    child: SubCategoryy(
                                                        services:
                                                            model.subCategory,
                                                        index: index),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget SubCategoryy(
      {required List<SubCategory> services, required int index}) {
    return Padding(
        padding: EdgeInsets.only(right: 8.6.w),
        child: InkWell(
          onTap: () {
            Get.to(() =>
                CategProdScreen(services[index].title!, services[index].id!));
          },
          child: Container(
            // height: 190.h,
            width: 100.w,
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
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
              ),
              child: Column(
                children: [
                  services[index].imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${services[index].imageUrl}',
                            width: 150.w,
                            height: 150.h,
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
                    child: Text('${services[index].title ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        style: bodyTextStyleLato.copyWith(
                            color: Colors.black, fontSize: 15.sp)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
