import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => ProductsViewModel(),
      child: Consumer<ProductsViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: BaseScreen(
              topPadding: 91,
              appBarChild: CustomAppBar(
                leadingIcon: '$staticAssets/back_icon.png',
                onLeadingPressed: () {
                  Get.offAll(RootScreen());
                },
                title: 'Products'.tr,
                // firstIcon: '$staticAssets/search_white.png',
                // firstIconOnTap: () {
                //   // Get.to(() => SearchScreen());
                // },
              ),
              body: model.isLoading
                  ? circularProgressIndicator()
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: topRoundedDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Flexible(
                                //   child: Text(
                                //     "Scroll down to view more\nproducts".tr,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: normalTextStyleLato.copyWith(
                                //         color: primaryColor,
                                //         decoration: TextDecoration.underline),
                                //   ),
                                // ),
                                IconButton(
                                    onPressed: () async {
                                      model.authService.allProducts =
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
                                                        child: FilterScreen());
                                                  }) ??
                                              model.authService.allProducts;
                                      setState(() {});
                                    },
                                    icon: Image.asset(
                                        '$staticAssets/filter_icon.png',
                                        height: 20.h,
                                        width: 20.w,
                                        color: primaryColor))
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Center(
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  itemCount:
                                      model.authService.allProducts.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio:
                                              width <= 340 && height <= 712
                                                  ? 1 / 1.4
                                                  : width <= 360.0 &&
                                                          height <= 732.0
                                                      ? 1 / 1.32
                                                      : 1 / 1.13,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 3, left: 3),
                                      child: InkWell(
                                        onTap: () async {
                                          model.authService.allProducts[index] =
                                              await Get.to(() =>
                                                      ProductDetailScreen(
                                                        isFirstTime: true,
                                                        product: model
                                                            .authService
                                                            .allProducts[index],
                                                      )) ??
                                                  model.authService
                                                      .allProducts[index];
                                          setState(() {});
                                        },
                                        child: ProductsContainer(
                                          onChange: () {
                                            model.toggleProductLike(
                                                model.authService.allProducts,
                                                index);
                                          },
                                          product: model
                                              .authService.allProducts[index],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
