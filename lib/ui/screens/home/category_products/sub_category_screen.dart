import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/responsive.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/home/category_products/category_product_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_viewmodel.dart';
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
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.86,
                                    child: Center(
                                        child:
                                            Text('sub_category_not_found'.tr)),
                                  )
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
                                                      // childAspectRatio: Get
                                                      //             .height >=
                                                      //         800
                                                      //     ? MediaQuery.of(
                                                      //                 context)
                                                      //             .size
                                                      //             .width /
                                                      //         (MediaQuery.of(
                                                      //                     context)
                                                      //                 .size
                                                      //                 .height /
                                                      //             1.86)
                                                      //     : MediaQuery.of(
                                                      //                 context)
                                                      //             .size
                                                      //             .width /
                                                      //         (MediaQuery.of(
                                                      //                     context)
                                                      //                 .size
                                                      //                 .height /
                                                      //             1.76),
                                                      crossAxisCount:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 2
                                                              : 3,
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
                                                        index: index,
                                                        context: context),
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
      {required List<SubCategory> services, required int index, context}) {
    return Padding(
        padding: EdgeInsets.only(right: 8.6.w),
        child: InkWell(
          onTap: () {
            print('...........${services[index].id!}');
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
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 0.15.sh,
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
                          color: Colors.black,
                          fontSize:
                              Responsive.isMobile(context) ? 15.sp : 20.sp,
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
