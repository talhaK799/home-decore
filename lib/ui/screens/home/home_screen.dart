import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/categories.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/responsive.dart';
import 'package:f2_base_project/ui/custom_widgets/app_banners_slider.dart';
import 'package:f2_base_project/ui/custom_widgets/home_prod_container.dart';
import 'package:f2_base_project/ui/custom_widgets/prod_shimmer.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/all_categories_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_screen.dart';
import 'package:f2_base_project/ui/screens/home/home_view_model.dart';
import 'package:f2_base_project/ui/screens/new_in_products/new_arrival_screen.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  bool isDrawerOpened = false;
  toggleAnimation() {
    if (animationController!.isDismissed) {
      isDrawerOpened = true;
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: primaryColor,
            key: model.scaffoldKey,
            body: ListView(
              // physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: primaryColor,
                  height: 84.h,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 30.h, 12.w, 0.h),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Image.asset('$staticAssets/drawer_icon.png',
                                  height: 20.h, width: 25.w),
                              onPressed: () {
                                print('open drawer');
                                toggleAnimation();
                                advancedDrawerController.showDrawer();
                                advancedDrawerController.value =
                                    AdvancedDrawerValue.visible();
                                if (advancedDrawerController.value.visible ==
                                    false) {
                                  advancedDrawerController.showDrawer();
                                  setState(() {});
                                }
                              },
                            ),
                            SizedBox(width: 7.w),
                            Text(
                              'Inna Home'.tr,
                              style: normalTextStyleLato.copyWith(
                                fontSize: Responsive.isMobile(context)
                                    ? 20.sp
                                    : 26.sp,
                              ),
                            )
                          ],
                        ),
                        Spacer(),

                        ///
                        ///
                        ///Removed search bar according to new design
                        ///
                        // SizedBox(width: 15.w),
                        // Expanded(
                        //   child: Container(
                        //     height: 30.h,
                        //     // width: 0.35.sw,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: TextField(
                        //       textInputAction: TextInputAction.search,
                        //       onSubmitted: (value) {
                        //         model.searchByName(value);
                        //       },
                        //       onChanged: (value) {
                        //         model.searchByName(value);
                        //       },
                        //       decoration: InputDecoration(
                        //           suffixIcon: UnconstrainedBox(
                        //             child: ImageContainer(
                        //                 height: 16.h,
                        //                 width: 16.w,
                        //                 assetImage:
                        //                     '$staticAssets/search.png'),
                        //           ),
                        //           contentPadding:
                        //               EdgeInsets.only(left: 13, bottom: 17),
                        //           border: InputBorder.none,
                        //           hintText: 'Search products'.tr,
                        //           hintStyle: normalTextStyleLato.copyWith(
                        //               fontSize: 13.sp,
                        //               color: Color(0xFFCFCFCF))),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(width: 11.w),
                        // IconButton(
                        //   color: whiteColor,
                        //   constraints: BoxConstraints(maxHeight: 23),
                        //   padding: EdgeInsets.zero,
                        //   onPressed: () {
                        //     PopupMenuButton(
                        //       itemBuilder: (context) => [
                        //         PopupMenuItem(
                        //           child: Text('English'),
                        //         )
                        //       ],
                        //     );
                        //   },
                        //   icon: Icon(Icons.language),
                        // ),
                        DropdownButton<String>(
                          underline: Container(),
                          style: buttonTextStyle.copyWith(
                            color: whiteColor,
                            fontSize:
                                Responsive.isMobile(context) ? 17.sp : 22.sp,
                          ),
                          dropdownColor: primaryColor,
                          value: model.selectedLang,
                          icon: Icon(
                            Icons.language,
                            color: whiteColor,
                            size: Responsive.isMobile(context) ? 18 : 28,
                          ),
                          onChanged: (val) {
                            model.selectLang(val);
                          },
                          items: model.languages
                              .map(
                                (val) => DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    val,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        IconButton(
                          constraints: BoxConstraints(maxHeight: 23),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (model.authService.isLogin) {
                              Get.to(() => CartScreen());
                            } else {
                              Get.dialog(SignupRequiredDialog('rootScreen'));
                            }
                          },
                          icon: model.authService.order.products == null
                              ? Image.asset(
                                  '$staticAssets/no-item-cart.png',
                                  width: Responsive.isMobile(context)
                                      ? 21.06.w
                                      : 30,
                                  height: Responsive.isMobile(context)
                                      ? 21.16.h
                                      : 30,
                                )
                              : Image.asset(
                                  '$staticAssets/cart-with-items1.png',
                                  width: Responsive.isMobile(context)
                                      ? 21.06.w
                                      : 30,
                                  height: Responsive.isMobile(context)
                                      ? 21.16.h
                                      : 30,
                                ),
                        )
                      ],
                    ),
                  ),
                ),

                ///
                /// Custom App Bar with icons and title
                ///
                // customAppBar(model),
                Stack(
                  children: [
                    // image Slider
                    AppBannersSlider(
                      image: model.banner,
                      // model.authService.banners,
                      height: 0.3.sh,
                      isCover: true,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 0.27.sh),
                        Container(
                          // height: 1.sh,
                          padding: EdgeInsetsDirectional.only(start: 20.w),
                          decoration: topRoundedDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25.h),

                              ///
                              /// categories
                              ///
                              // Padding(
                              //   padding:
                              //       EdgeInsetsDirectional.only(start: 8.0),
                              //   child: Text(
                              //     'Categories'.tr,
                              //     style: normalTextStyleLato.copyWith(
                              //         fontSize: 18.sp, color: blackColor),
                              //   ),
                              // ),
                              customViewAllRow(
                                  'categories'.tr,
                                  () => Get.to(() => AllCategoriesScreen(
                                      title: 'categories'.tr,
                                      newInProductsList:
                                          model.authService.categories))),
                              SizedBox(height: 12.h),
                              Container(
                                height: 160.h,
                                child: model.isShimmer
                                    ? ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          return ProdShimmer(
                                              width: 153.w,
                                              height: 200.h,
                                              radius: 10.0);
                                        })
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            model.authService.categories.length,
                                        itemBuilder: (context, index) {
                                          return categories(
                                              model.authService.categories,
                                              index);
                                        },
                                      ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),

                              /// =========================================================
                              /// New Arrivals
                              ///
                              customViewAllRow(
                                  'new_arrivals'.tr,
                                  () => Get.to(() => NewArrivalScreen(
                                      title: 'new_in'.tr,
                                      newInProductsList:
                                          model.authService.latestProducts))),
                              SizedBox(height: 8.h),

                              Container(
                                height: 190.h,
                                child:

                                    ///
                                    /// Show shimmer effect until products loaded successfully
                                    ///
                                    model.isShimmer
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              return ProdShimmer(
                                                  width: 153.w,
                                                  height: 200.h,
                                                  radius: 10.0);
                                            })
                                        : model.searchedProducts.isEmpty
                                            ? newInProductsList(
                                                model,
                                                model
                                                    .authService.latestProducts)
                                            : newInProductsList(
                                                model, model.searchedProducts),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),

                              /// ============================================
                              /// Top Rated products
                              ///
                              customViewAllRow(
                                  'top_rated_products'.tr,
                                  () => Get.to(() => NewArrivalScreen(
                                      title: 'top_rated'.tr,
                                      newInProductsList:
                                          model.authService.topRatedProducts))),

                              SizedBox(height: 8.h),

                              Container(
                                height: 190.h,
                                child:

                                    ///
                                    /// Show shimmer effect until products loaded successfully
                                    ///
                                    model.isShimmer
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              return ProdShimmer(
                                                  width: 153.w,
                                                  height: 200.h,
                                                  radius: 10.0);
                                            })
                                        : newInProductsList(model,
                                            model.authService.topRatedProducts),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),

                              /// =========================================================
                              ///
                              /// All Products
                              ///

                              customViewAllRow(
                                  'all_products'.tr,
                                  () => Get.offAll(
                                      () => RootScreen(selectedPage: 1))),

                              SizedBox(height: 8.h),
                              Container(
                                height: 190.h,
                                child:

                                    ///
                                    /// Show shimmer effect until products loaded successfully
                                    ///
                                    model.isShimmer
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              return ProdShimmer(
                                                  width: 153.w,
                                                  height: 200.h,
                                                  radius: 10.0);
                                            })
                                        : newInProductsList(model,
                                            model.authService.allProducts),
                              ),
                              SizedBox(height: 70.h),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  customViewAllRow(String title, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10.0),
            child: Text(
              title,
              style: boldTextStyleLato.copyWith(
                  fontSize: 18.sp, color: blackColor),
            ),
          ),
          Row(
            children: [
              Text(
                'view_all'.tr,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 15.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(width: 20.w)
            ],
          )
        ],
      ),
    );
  }

  Widget newInProductsList(HomeViewModel model, List<Product> products) {
    return products.isEmpty
        ? Center(child: Text('searched_prod_not_found'.tr))
        : ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  model.authService.order.products =
                      await Get.to(() => ProductDetailScreen(
                                isFirstTime: true,
                                product: products[index],
                              )) ??
                          model.authService.order.products;
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 0.w, bottom: 10.h, end: 16),
                  child: HomeProdContainer(
                    onChange: () {
                      model.toggleProductLike(products, index);
                    },
                    product: products[index],
                  ),
                ),
              );
            },
          );
  }

  Widget categories(List<Categories> services, int index) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Get.to(() =>
              SubCategoryScreen(services[index].title!, services[index].id!));
        },
        child: Container(
          // height: 120.h,
          // width: 135.w,
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
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
            child: Column(
              children: [
                services[index].iconUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '${services[index].iconUrl}',
                          width: Responsive.isMobile(context) ? 130 : 0.2.sw,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 130.w,
                        height: 100.h,
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
                    // maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: boldTextStyleHacen.copyWith(
                        fontSize: 14.sp,
                        color: blackColor,
                        fontFamily: latoFont,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
