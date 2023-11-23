import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/home/category_products/category_product_screen.dart';
import 'package:f2_base_project/ui/screens/offers/offers_view_model.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OfferScreen extends StatelessWidget {
  final bool? isAbove;
  OfferScreen({this.isAbove = false});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OffersViewModel(),
      child: Consumer<OffersViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color(0XFFE4E4E4),
          // bottomNavigationBar: BottomNavBar(3),
          body: BaseScreen(
            topPadding: 91,
            appBarChild: CustomAppBar(
              leadingIcon: '$staticAssets/back_icon.png',
              onLeadingPressed: () {
                Get.offAll(RootScreen());
              },
              title: 'offers'.tr,
            ),
            body: model.isLoading
                ? circularProgressIndicator()
                : model.isLoading
                    ? circularProgressIndicator()
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: model.authService.offers.isEmpty
                            ? Center(child: Text('offers_not_found'.tr))
                            : _categoriesStackView(
                                model, model.authService.offers)),
          ),
        ),
      ),
    );
  }

  _categoriesStackView(OffersViewModel model, List<Offers> offers) {
    return Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CategProdScreen(
                                        '${offers[index].category}',
                                        isFromOffers: true,
                                        offer: offers[index])));
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.grey.withOpacity(0.2),
                                        child: FadeInImage.assetNetwork(
                                          height: 200.h,
                                          width: 1.sw,
                                          placeholder: productPlaceHolder,
                                          image: '${offers[index].imageUrl}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),

                                    ///
                                    /// discount banner
                                    Positioned(
                                        top: 150.h,
                                        right: 20.w,
                                        child: Container(
                                          width: 1.sw,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 80.9.w,
                                                height: 33.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0xFFFF4545),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      offers[index]
                                                                  .percentage ==
                                                              null
                                                          ? 'BDT ${offers[index].flatDiscount} Flat'
                                                          : int.parse(offers[
                                                                          index]
                                                                      .percentage!) ==
                                                                  0
                                                              ? 'BDT ${offers[index].flatDiscount} Flat'
                                                              : '${offers[index].percentage}% OFF',
                                                      style: buttonTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              fontFamily:
                                                                  latoFont)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '${offers[index].title}',
                                  style: headingTextStyleLato.copyWith(
                                      color: primaryColor),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '${offers[index].description}',
                                  style: bodyTextStyleLato.copyWith(
                                      color: primaryColor),
                                ),
                              ]),
                        ),
                      );
                    }),
              ),
            ),
            isAbove == false ? SizedBox(height: 80.h) : Container(),
          ],
        ));
  }
}
