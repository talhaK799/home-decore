import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/screens/new_in_products/new_in_products_view_model.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
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
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
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
                                                    childAspectRatio: width <=
                                                                340 &&
                                                            height <= 712
                                                        ? 1 / 1.4
                                                        : width <= 360.0 &&
                                                                height <= 732.0
                                                            ? 1 / 1.3
                                                            : 1 / 1.13,
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 4,
                                                    crossAxisSpacing: 4),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0,
                                                    left: 3,
                                                    right: 3),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    newInProductsList[
                                                        index] = await Get.to(() =>
                                                            ProductDetailScreen(
                        isFirstTime: true,
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
                                                    product: newInProductsList[
                                                        index],
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
