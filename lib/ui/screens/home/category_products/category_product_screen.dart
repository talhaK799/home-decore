import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/responsive.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/screens/home/category_products/categ_prod_view_model.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategProdScreen extends StatelessWidget {
  String subCategory;
  String? subCategoryId;
  bool isFromOffers;
  Offers? offer;
  CategProdScreen(this.subCategory, this.subCategoryId,
      {this.isFromOffers = false, this.offer});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategProdViewModel(
          subCategory, isFromOffers, offer ?? null, subCategoryId!),
      child: Consumer<CategProdViewModel>(
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
                  title: '$subCategory',
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      model.products =
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
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20)),
                                                        child: FilterScreen(
                                                            products: model
                                                                .products));
                                                  }) ??
                                              model.products;
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
                            model.products.isEmpty
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.78,
                                    child: Center(
                                      child: Text(
                                          'products_not_found_in_this_category'
                                              .tr),
                                    ),
                                  )
                                : Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: GridView.builder(
                                                primary: false,
                                                itemCount:
                                                    model.products.length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        //    childAspectRatio: Get.height >= 800
                                                        // ? MediaQuery.of(context).size.width /
                                                        //     (MediaQuery.of(context).size.height / 1.82)
                                                        // : MediaQuery.of(context).size.width /
                                                        //     (MediaQuery.of(context).size.height / 1.67),
                                                        crossAxisCount:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 2
                                                                : 3,
                                                        mainAxisSpacing: 15,
                                                        crossAxisSpacing: 15),
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            left: 3,
                                                            right: 3),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(ProductDetailScreen(
                                                            isFirstTime: true,
                                                            isFromOffer:
                                                                isFromOffers,
                                                            offer: offer,
                                                            product:
                                                                model.products[
                                                                    index]));
                                                      },
                                                      child: ProductsContainer(
                                                        onChange: () {
                                                          model
                                                              .toggleProductLike(
                                                                  model
                                                                      .products,
                                                                  index);
                                                        },
                                                        product: model
                                                            .products[index],
                                                      ),
                                                    ),
                                                  );
                                                }),
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
                )),
          );
        },
      ),
    );
  }
}
