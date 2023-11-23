import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/authentication_app_bar.dart';
import 'package:f2_base_project/ui/screens/home/home_search/home_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomeSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeSearchViewModel(),
      child: Consumer<HomeSearchViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),

                    ///
                    /// custom app bar
                    ///
                    AuthenticationAppBar(
                      leadingIcon: '$staticAssets/cancel_icon.png',
                      color: Colors.black,
                      onBack: () => Get.back(),
                      heading: "search".tr,
                      isHeadingBold: true,
                    ),

                    ///
                    /// Search Bar
                    ///
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 25.h),
                      child: Container(
                        height: 49.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xFFCFCFCF))),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if (model.searchingText != null) {
                              // model.searchProducts();
                            }
                          },
                          onChanged: (value) {
                            model.searchingText = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: Get.locale!.languageCode == 'ar'
                                  ? EdgeInsets.only(top: 3)
                                  : null,
                              // suffixIcon: TextButton(
                              //   onPressed: () {
                              //     model.searchProducts();
                              //   },
                              //   child: Text('search'.tr,
                              //       style: bodyTextStyle.copyWith(
                              //           color: primaryColor)),
                              // ),
                              // prefixIconConstraints: BoxConstraints(
                              //     maxHeight: 15.h, maxWidth: 15.w),
                              prefixIcon: UnconstrainedBox(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 7.0, right: 3),
                                  child: Image(
                                    image: AssetImage(
                                      '$staticAssets/search_black.png',
                                    ),
                                    height: 19.h,
                                    width: 19.w,
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'search_text'.tr,
                              hintStyle: normalTextStyleLato.copyWith(
                                  color: Color(0xFFCFCFCF))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
