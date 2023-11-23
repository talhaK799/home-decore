import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/radio_button.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_address/add_cart_address/add_cart_address_screen.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CartAddressScreen extends StatefulWidget {
  @override
  _CartAddressScreenState createState() => _CartAddressScreenState();
}

class _CartAddressScreenState extends State<CartAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
              backgroundColor: Colors.white,
              body: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          backgroundColor: primaryColor),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 00.h, 27.3.w, 10.h),
                      child: ListView(
                        children: [
                          ///
                          /// Address Tiles
                          ///
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              itemCount: model.addresses.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: addressTile(
                                      userAddress: model.addresses[index],
                                      model: model,
                                      selectedAddress: model.selectedAddress,
                                      onChange: (value) {
                                        model.selectAddress(index);
                                      },
                                      index: index),
                                );
                              }),
                          SizedBox(height: 30.h),
                          Container(height: 0.13.h, color: greyColor),
                          SizedBox(height: 25.h),

                          ///
                          /// Add new address
                          ///
                          InkWell(
                            onTap: () async {
                              if (model.authService.isLogin) {
                                model.addresses = await Get.to(() =>
                                        AddCartAddressScreen(
                                            model.addresses)) ??
                                    model.addresses;
                                model.getUserAddress();
                                setState(() {});
                              } else {
                                Get.dialog(SignupRequiredDialog('rootScreen'));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('$staticAssets/add_icon.png',
                                    width: 23.w, height: 23.h),
                                SizedBox(width: 8.w),
                                Text('add_new_address'.tr,
                                    style: bodyTextStyleLato.copyWith(
                                        fontSize: 17.sp))
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h),
                          //
                          /// Total and Sub total Prices
                          ///

                          Divider(color: Color(0xFF58595B)),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Charges'.tr,
                                  style: TextStyle(
                                      fontSize: 13.sp, fontFamily: latoFont)),
                              Text(
                                  model.addresses.isEmpty
                                      ? '...'
                                      : '${model.addresses[model.selectedAddress].city == 'Dhaka' ? 'BDT 70' : 'BDT 130'}',
                                  style: TextStyle(
                                      fontSize: 12.sp, fontFamily: latoFont)),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Container(height: 0.13.h, color: greyColor),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('total'.tr,
                                  style: TextStyle(
                                      fontSize: 13.sp, fontFamily: latoFont)),
                              Text(
                                  model.addresses.isEmpty
                                      ? 'BDT ${double.parse(model.authService.order.totalPrice ?? '00').toStringAsFixed(2)}'
                                      : 'BDT ${model.addresses[model.selectedAddress].city == 'Dhaka' ? (double.parse(model.authService.order.totalPrice ?? '0') + 70).toStringAsFixed(2) : (double.parse(model.authService.order.totalPrice ?? '0') + 130).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 12.sp, fontFamily: latoFont)),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Center(
                              child: Text(
                                  'Please note that the delivery will take 3-7 days',
                                  style: bodyTextStyleLato.copyWith(
                                      fontSize: 14.sp, color: primaryColor))),
                          SizedBox(height: 30.h),

                          ///
                          /// Checkout Button
                          ///
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RectangularButton(
                                radius: 9,
                                width: 160.w,
                                buttonColor: primaryColor,
                                textStyle: boldTextStyleLato.copyWith(
                                    fontSize: 19.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                title: 'Checkout',
                                onTap: () {
                                  model.checkout();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
        );
      },
    );
  }

  Widget addressTile(
      {UserAddress? userAddress,
      CartViewModel? model,
      selectedAddress,
      onChange,
      index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RadioButton(
                  value: index,
                  groupValue: selectedAddress,
                  activeColor: primaryColor,
                  inActiveColor: primaryColor,
                  onChange: onChange,
                ),
                Text('${userAddress!.name}',
                    style: bodyTextStyleLato.copyWith(fontSize: 19.sp)),
              ],
            ),
            InkWell(
                onTap: () {
                  model!.deleteAddress(model.addresses[index]);
                },
                child: Icon(Icons.delete, color: primaryColor)),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 51.4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${userAddress.address} ${userAddress.city}',
                  style: bodyTextStyleLato.copyWith(fontSize: 13)),
              Text('Mobile: ${userAddress.countryCode} ${userAddress.phone}',
                  style: bodyTextStyleLato.copyWith(fontSize: 13))
            ],
          ),
        )
      ],
    );
  }
}
