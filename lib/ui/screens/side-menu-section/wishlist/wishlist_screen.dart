import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/products_container.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/filter/filter_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/wishlist/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => WishListProvider(),
      child: Consumer<WishListProvider>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: BaseScreen(
                topPadding: 91,
                appBarChild: CustomAppBar(
                  leadingIcon: '$staticAssets/back_icon.png',
                  onLeadingPressed: () {
                    Get.back();
                  },
                  title: 'Wishlisted Products'.tr,
                  // firstIcon: '$staticAssets/search_white.png',
                  // firstIconOnTap: () {
                  //   Get.to(() => SearchScreen());
                  // },
                ),
                body: model.isLoading
                    ? circularProgressIndicator()
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: topRoundedDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        model.wishlistedProducts =
                                            await showModalBottomSheet(
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                                  .wishlistedProducts));
                                                    }) ??
                                                model.wishlistedProducts;
                                        setState(() {});
                                      },
                                      icon: Image.asset(
                                          '$staticAssets/filter_icon.png',
                                          height: 20.h,
                                          width: 20.w,
                                          color: primaryColor)),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      itemCount: model.wishlistedProducts.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                               childAspectRatio: Get.height >= 800
                                                  ? MediaQuery.of(context).size.width /
                                                      (MediaQuery.of(context).size.height / 1.85)
                                                  : MediaQuery.of(context).size.width /
                                                      (MediaQuery.of(context).size.height / 1.67),
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 4,
                                              crossAxisSpacing: 4),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, left: 3, right: 3),
                                          child: GestureDetector(
                                            onTap: () async {
                                              model.wishlistedProducts[
                                                  index] = await Get.to(
                                                      () => ProductDetailScreen(
                                                          isFirstTime: true,
                                  
                                                            product: model
                                                                    .wishlistedProducts[
                                                                index],
                                                          )) ??
                                                  model.wishlistedProducts[index];
                                              setState(() {});
                                            },
                                            child: ProductsContainer(
                                              onChange: () {
                                                model.toggleProductLike(
                                                    model.wishlistedProducts,
                                                    index);
                                              },
                                              product:
                                                  model.wishlistedProducts[index],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(height: 100.h),
                            ],
                          ),
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
