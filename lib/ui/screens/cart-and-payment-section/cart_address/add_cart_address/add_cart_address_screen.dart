import 'package:country_picker/country_picker.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/rounded-raised-button.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_address/add_cart_address/add_cart_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet.dart';

class AddCartAddressScreen extends StatelessWidget {
  final List<UserAddress> userAddress;
  AddCartAddressScreen(this.userAddress);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddCartAddressViewModel(),
      child: Consumer<AddCartAddressViewModel>(
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
                  title: 'Add New Address'.tr,
                ),

                ///
                ///screen body
                ///
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 38.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //add new address form
                          addNewAddressForm(model, context),

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
  addNewAddressForm(AddCartAddressViewModel model, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 55.0 - 25.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          textfield(
              label: "name".tr,
              onChange: (value) {
                model.userAddress.name = value;
              }),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("country_code".tr,
                    style: bodyTextStyleLato.copyWith(
                        color: primaryColor, fontSize: 16.sp)),
                Container(
                    height: 40.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.3)))),
                    child: Text(model.userAddress.countryCode ?? '+973',
                        style: bodyTextStyleLato.copyWith(
                            fontSize: model.userAddress.countryCode == null
                                ? 10.sp
                                : 16.sp,
                            color: model.userAddress.countryCode == null
                                ? Colors.black.withOpacity(0.5)
                                : Colors.black))),
              ],
            ),
          ),
          textfield(
            hintText: '017XXXXXXXX',
            label: "phone".tr,
            onChange: (value) {
              model.userAddress.phone = value;
            },
            textInputType: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("country".tr,
                    style: bodyTextStyleLato.copyWith(
                        color: primaryColor, fontSize: 16.sp)),
                Container(
                    height: 40.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.3)))),
                    child: Text(model.userAddress.country ?? 'Bangladesh',
                        style: bodyTextStyleLato.copyWith(
                            fontSize: model.userAddress.country == null
                                ? 10.sp
                                : 16.sp,
                            color: model.userAddress.country == null
                                ? Colors.black.withOpacity(0.5)
                                : Colors.black))),
              ],
            ),
          ),

          ///
          /// pick city name
          ///
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
                width: 0.3.sw,
                child: GestureDetector(
                    onTap: () async {
                      print('onTap');
                      model.userAddress.city = await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              context: context,
                              builder: (context) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: CitiesBottomSheet());
                              }) ??
                          model.userAddress.city;
                      model.setState(ViewState.idle);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("city".tr,
                            style: bodyTextStyleLato.copyWith(
                                color: primaryColor, fontSize: 16.sp)),
                        Container(
                            height: 50.h,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)))),
                            child: Text('${model.userAddress.city}',
                                style: bodyTextStyleLato.copyWith(
                                    fontSize: 16.sp, color: Colors.black))),
                      ],
                    ))),
          ),
          textfield(
              label: "address".tr,
              hintText:
                  'Apartment, Suite, Unit, Building, Area, Upazila etc Details',
              onChange: (value) {
                model.userAddress.address = value;
              }),

          // textfield(label: "Address2"),
          textfield(
              isRequired: false,
              label: "Any special note".tr,
              onChange: (value) {
                model.userAddress.postalCode = value;
              }),
        ],
      ),
    );
  }

  textfield(
      {label,
      onChange,
      textInputType,
      isRequired = true,
      hintText,
      isReadOnly = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 25.8),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("$label",
                  style: bodyTextStyleLato.copyWith(
                      color: primaryColor,
                      fontSize: label == "country_code".tr ? 10.sp : 16.sp))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextFormField(
                readOnly: isReadOnly,
                textCapitalization: TextCapitalization.sentences,
                cursorColor: primaryColor,
                keyboardType: textInputType ?? TextInputType.text,
                validator: isRequired
                    ? (value) {
                        if (value!.isEmpty) {
                          return "required_field".tr;
                        } else {
                          return null;
                        }
                      }
                    : (value) => null,
                onChanged: onChange,
                decoration: InputDecoration(
                    hintText: hintText ?? '',
                    hintStyle: bodyTextStyleLato.copyWith(
                        fontSize: 10.sp, color: Colors.black.withOpacity(0.5)),
                    contentPadding: EdgeInsets.only(top: 20),
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
          ),
        ],
      ),
    );
  }

  //save button
  saveButton(AddCartAddressViewModel model) {
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
                  model.saveAddress(userAddress);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  ///
  /// gettting country code and country name
  ///

  getCountryNameAndCode(context, onTap) {
    return showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: primaryColor),
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          hintText: 'search'.tr,
          prefixIcon: Icon(Icons.search, color: primaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
      ),
      onSelect: onTap,
    );
  }
}
