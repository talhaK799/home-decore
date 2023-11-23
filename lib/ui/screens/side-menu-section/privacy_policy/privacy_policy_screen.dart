import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/privacy_policy/privacy_policy_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrivacyPolicyViewModel(),
      child: Consumer<PrivacyPolicyViewModel>(
        builder: (context, model, child) {
          return BaseScreen(
            topPadding: 91,
            appBarChild: CustomAppBar(
              leadingIcon: '$staticAssets/back_icon.png',
              title: 'Terms & Conditions'.tr,
            ),
            body: model.state == ViewState.busy
                ? Center(child: circularProgressIndicator())
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(58.w, 43.h, 43.h, 0),
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Container(
                              width: 1.sw,
                              child: Text(
                                '${model.terms.terms}',
                                style: bodyTextStyleLato.copyWith(),
                              ),
                            ))),
                  ),
          );
        },
      ),
    );
  }
}
