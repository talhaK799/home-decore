import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom-expansion-tile.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/search_field.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/faq/faq_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FaqsViewModel(),
      child: Consumer<FaqsViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            progressIndicator: circularProgressIndicator(),
            inAsyncCall: model.state == ViewState.busy,
            child: BaseScreen(
              topPadding: 91,
              appBarChild: CustomAppBar(
                leadingIcon: '$staticAssets/back_icon.png',
                title: 'Faqs',
              ),
              body: Padding(
                padding: EdgeInsetsDirectional.only(start: 30.w, top: 20.h),
                child: ListView(
                  children: [
                    ///
                    /// Search field
                    ///
                    // Padding(
                    //   padding: EdgeInsetsDirectional.only(end: 30),
                    //   child: SearchField(
                    //     hintText: 'keyword_search'.tr,
                    //     // onChange: (value) => model.searchFaqs(value),
                    //     height: 57.7.h,
                    //   ),
                    // ),

                    ///
                    /// FAQs about sport app
                    ///
                    // SizedBox(height: 24.h),
                    Text('About Horitoki',
                        style: titleTextStyle.copyWith(
                          color: primaryColor,
                          fontFamily: latoFont,
                          fontSize: 26.sp,
                        )),
                    SizedBox(height: 10.h),
                    model.faqs.length == 0
                        ? Center(child: Text("No Faqs found"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.faqs.length,
                            itemBuilder: (context, index) {
                              return expansionFilters(
                                  '${model.faqs[index].queston}',
                                  '${model.faqs[index].answer}');
                            }),

                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget expansionFilters(String question, String answer) {
    return Theme(
      data: ThemeData.light().copyWith(
          unselectedWidgetColor: Color(0xFFFAACAC),
          // accentColor: Color(0xFFFAACAC),
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary:
                    Color(0xFFFAACAC), // Modify primary color as an example
              ),
          dividerColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: CustomExpansionTile(
            onExpansionChanged: (value) {},
            tilePadding: EdgeInsets.only(right: 20.w),
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            title: Text(
              '$question',
              style: bodyTextStyleLato.copyWith(fontSize: 21.sp),
            ),
            children: [
              Text(
                '$answer',
                style: bodyTextStyleLato.copyWith(fontSize: 17.sp),
              )
            ]),
      ),
    );
  }
}
