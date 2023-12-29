import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/radio_button.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_address/add_cart_address/add_cart_address_screen.dart';
import 'package:f2_base_project/ui/screens/profile/address_screen/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddressViewModel(),
      child: Consumer<AddressViewModel>(
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: BaseScreen(
                topPadding: 91,
                appBarChild: CustomAppBar(
                  leadingIcon: '$staticAssets/back_icon.png',
                  title: 'My Addresses'.tr,
                ),
                body: model.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            backgroundColor: primaryColor),
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 00.h, 27.3.w, 30.h),
                        child: ListView(
                          children: [
                            ///
                            /// Address Tiles
                            ///
                            ListView.builder(
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
                            SizedBox(height: 30.h),

                            ///
                            /// Add new address
                            ///
                            InkWell(
                              onTap: () async {
                                model.addresses = await Get.to(() =>
                                        AddCartAddressScreen(
                                            model.addresses)) ??
                                    model.addresses;
                                model.getUserAddress();
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text('add_new_address'.tr,
                                      style: bodyTextStyleLato.copyWith(
                                          fontSize: 17.sp))
                                ],
                              ),
                            ),
                            SizedBox(height: 50.h),
                          ],
                        ),
                      ),
              ));
        },
      ),
    );
  }

  Widget addressTile(
      {UserAddress? userAddress,
      AddressViewModel? model,
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
                  Get.dialog(
                    AlertDialog(
                      title: Text("Delete"),
                      content: Text("Are you sure to delete the address?"),
                      actions: [
                        ElevatedButton(
                          child: Text("Yes"),
                          onPressed: () {
                            model!.deleteAddress(model.addresses[index]);
                          },
                        ),
                        ElevatedButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
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
              Text(
                  '${'Mobile'.tr}: ${userAddress.countryCode} ${userAddress.phone}',
                  style: bodyTextStyleLato.copyWith(fontSize: 13))
            ],
          ),
        )
      ],
    );
  }
}
