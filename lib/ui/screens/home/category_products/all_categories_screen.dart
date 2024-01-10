import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/categories.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_screen.dart';
import 'package:f2_base_project/ui/screens/new_in_products/new_in_products_view_model.dart';
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
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.86,
                                  child: Center(child: Text('searched_prod_not_found'.tr)),
                                  )
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
                                                //    childAspectRatio: Get.height >= 800
                                                // ? MediaQuery.of(context).size.width /
                                                //     (MediaQuery.of(context).size.height / 1.99)
                                                // : MediaQuery.of(context).size.width /
                                                //     (MediaQuery.of(context).size.height / 1.76),
                                                
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
                        width: 140.w,
                        height: 130.h,
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
     );
  }
}
