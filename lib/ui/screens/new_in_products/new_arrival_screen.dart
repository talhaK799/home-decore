import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/responsive.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/screens/new_in_products/new_in_products_view_model.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NewArrivalScreen extends StatelessWidget {
  List<Product> newInProductsList;
  String? title;
  NewArrivalScreen({required this.newInProductsList, required this.title});

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
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    newInProductsList =
                                        await showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20)),
                                                      child: FilterScreen());
                                                }) ??
                                            newInProductsList;
                                    model.setState(ViewState.idle);
                                  },
                                  icon: Image.asset(
                                      '$staticAssets/filter_icon.png',
                                      height: 20.h,
                                      width: 20.w,
                                      color: primaryColor))
                            ],
                          ),
                          SizedBox(height: 5.h),

                          // /
                          // / Scrollable New Products
                          // /
                          // model.getFilteredProd.baseProduct.products.isEmpty
                          //     ?
                          newInProductsList.isEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.86,
                                  child: Center(
                                      child:
                                          Text('searched_prod_not_found'.tr)),
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
                                                    //     (MediaQuery.of(context).size.height / 1.78)
                                                    // : MediaQuery.of(context).size.width /
                                                    //     (MediaQuery.of(context).size.height / 1.6),
                                                    crossAxisCount:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 2
                                                            : 3,
                                                    // childAspectRatio:
                                                    //     Responsive.isMobile(
                                                    //             context)
                                                    //         ? 0.8 / 1
                                                    //         : 1.2,
                                                    mainAxisSpacing: 15,
                                                    crossAxisSpacing: 15),
                                            itemBuilder: (context, index) {
                                              return GridTile(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3, right: 3),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      newInProductsList[index] =
                                                          await Get.to(() =>
                                                                  ProductDetailScreen(
                                                                    isFirstTime:
                                                                        true,
                                                                    product:
                                                                        newInProductsList[
                                                                            index],
                                                                  )) ??
                                                              newInProductsList[
                                                                  index];
                                                      model.setState(
                                                          ViewState.idle);
                                                    },
                                                    child: ProductsContainer(
                                                      onChange: () {
                                                        model.toggleProductLike(
                                                            newInProductsList,
                                                            index);
                                                      },
                                                      product:
                                                          newInProductsList[
                                                              index],
                                                    ),
                                                  ),
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
              ));
        },
      ),
    );
  }
}
