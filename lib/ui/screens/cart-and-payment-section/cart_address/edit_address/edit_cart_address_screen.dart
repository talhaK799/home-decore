import 'dart:math';

import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/custom_widgets/rounded-raised-button.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_address/edit_address/edit_cart_address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditCartAddressScreen extends StatelessWidget {
  final int? index;

  EditCartAddressScreen({this.index});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditCartAddressViewModel(),
      child: Consumer<EditCartAddressViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: BaseScreen(
                topPadding: 91,

                ///
                ///appbar body
                ///
                appBarChild: CustomAppBar(
                  leadingIcon: '$staticAssets/back_icon.png',
                  onLeadingPressed: () {
                    Get.back();
                  },
                  title: 'Edit Address'.tr,
                ),

                ///
                ///screen body
                ///
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 38.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //add new address form
                          addNewAddressForm(model),

                          //save button
                          saveButton(model),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  //add new address form
  addNewAddressForm(EditCartAddressViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 55.0 - 25.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          textfield(
              initialValue: model.editUserAddress.name,
              label: "name".tr,
              onChange: (value) {
                model.editUserAddress.name = value;
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: textfield(
                    initialValue: model.editUserAddress.countryCode,
                    label: "country_code".tr,
                    onChange: (value) {
                      model.editUserAddress.countryCode = value;
                    },
                    textInputType: TextInputType.number),
              ),
              SizedBox(
                width: 28.0,
              ),
              Expanded(
                flex: 3,
                child: textfield(
                  initialValue: model.editUserAddress.phone,
                  label: "phone".tr,
                  onChange: (value) {
                    model.editUserAddress.phone = value;
                  },
                  textInputType: TextInputType.number,
                ),
              ),
            ],
          ),
          textfield(
              initialValue: model.editUserAddress.country,
              label: "country".tr,
              onChange: (value) {
                model.editUserAddress.country = value;
              }),
          textfield(
              initialValue: model.editUserAddress.city,
              label: "city".tr,
              onChange: (value) {
                model.editUserAddress.city = value;
              }),
          textfield(
              initialValue: model.editUserAddress.address,
              label: "address".tr,
              onChange: (value) {
                model.editUserAddress.address = value;
              }),
          // textfield(label: "Address2"),
          textfield(
              initialValue: model.editUserAddress.postalCode,
              label: "postal_code".tr,
              onChange: (value) {
                model.editUserAddress.postalCode = value;
              }),
        ],
      ),
    );
  }

  textfield({label, onChange, textInputType, initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.8),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("$label",
                  style: bodyTextStyleLato.copyWith(
                      color: primaryColor,
                      fontSize: label == "country_code".tr ? 10 : 16.sp))
            ],
          ),
          TextFormField(
              initialValue: initialValue,
              keyboardType: textInputType ?? TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "required_field".tr;
                } else {
                  return null;
                }
              },
              onChanged: onChange,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.3))),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.3))),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.3))))),
        ],
      ),
    );
  }

  //save button
  saveButton(EditCartAddressViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 55.8, top: 42.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 41.h,
            width: 133.w,
            child: RoundedRaisedButton(
              text: "save".tr,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // model.editCartAddress(userAddressResponse!, index!);
                }
              },
            ),
          )
        ],
      ),
    );
    ;
  }
}
