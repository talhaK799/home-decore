import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/categories.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_screen.dart';
import 'package:f2_base_project/ui/screens/new_in_products/new_in_products_view_model.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AllCategoriesScreen extends StatelessWidget {
  List<Categories> newInProductsList;
  String? title;
  AllCategoriesScreen({required this.newInProductsList, required this.title});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => NewInProductsViewModel(),
      child: Consumer<NewInProductsViewModel>(
        builder: (context, model, child) {
          return BaseScreen(
              // bottomNavBar: BottomNavBar(4),
              topPadding: 91,

              ///
              /// custom App Bar
              ///
              appBarChild: CustomAppBar(
                leadingIcon: '$staticAssets/back_icon.png',
                title: '$title',
              ),

              ///
              /// New Arrivals List
              ///
              body: Container(
                alignment: Alignment.center,
                decoration: topRoundedDecoration,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     IconButton(
                          //         onPressed: () async {
                          //           newInProductsList =
                          //               await showModalBottomSheet(
                          //                       shape: RoundedRectangleBorder(
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 20.0),
                          //                       ),
                          //                       context: context,
                          //                       builder: (context) {
                          //                         return ClipRRect(
                          //                             borderRadius:
                          //                                 BorderRadius.only(
                          //                                     topLeft: Radius
                          //                                         .circular(20),
                          //                                     topRight: Radius
                          //                                         .circular(
                          //                                             20)),
                          //                             child: FilterScreen());
                          //                       }) ??
                          //                   newInProductsList;
                          //           model.setState(ViewState.idle);
                          //         },
                          //         icon: Image.asset(
                          //             '$staticAssets/filter_icon.png',
                          //             height: 20.h,
                          //             width: 20.w,
                          //             color: primaryColor))
                          //   ],
                          // ),
                          SizedBox(height: 5.h),

                          ///
                          /// Scrollable New Products
                          ///
                          // model.getFilteredProd.baseProduct.products.isEmpty
                          //     ?
                          newInProductsList.isEmpty
                              ? Center(
                                  child: Text('searched_prod_not_found'.tr))
                              : Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: GridView.builder(
                                          primary: false,
                                          itemCount: newInProductsList.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.76),
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 15,
                                                  crossAxisSpacing: 15),
                                          itemBuilder: (context, index) {
                                            return categorie(
                                                model.authService.categories,
                                                index);
                                          },
                                        ),
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
              ));
        },
      ),
    );
  }

  Widget categorie(List<Categories> services, int index) {
    return InkWell(
      onTap: () {
        Get.to(() =>
            SubCategoryScreen(services[index].title!, services[index].id!));
      },

      child: Container(
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
          padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
          child: Column(
            children: [
              services[index].iconUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${services[index].iconUrl}',
                        width: 140.w,
                        height: 130.h,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 118.w,
                      height: 118.h,
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
    );
  }
}
