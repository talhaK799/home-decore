import 'dart:math';

import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/custom-text-field2.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_text_field.dart';
import 'package:f2_base_project/ui/screens/contact_us/contact_us_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactUsProvider(),
      child: Consumer<ContactUsProvider>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state ==ViewState.busy,
          child: Scaffold(
            
            body: SafeArea(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    SizedBox(height: 60.h),
                    Center(child: Row(
                      children: [
                         Transform(
              alignment: Alignment.center,
              transform: Get.locale!.languageCode == 'ar'
                  ? Matrix4.rotationY(pi)
                  : Matrix4.rotationY(0),
              child: IconButton(
                icon: Image.asset('$staticAssets/back_icon.png',
                    height: 22.h, width: 11.w, color: primaryColor),
                onPressed: () {
                  Get.back();
                },
              )),
                        Text("Contact Us", style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),),
                      ],
                    )),
                    SizedBox(height: 20),
              
                     TextFormField(
                             
                               
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter subject name".tr;
                                  } else {
                                    return null;
                                  }
                                },
                               
                                onChanged: (value) {
                                  model.contactUs.title = value;
                                },
                                decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                   hintText: "Subject".tr,
                                ),
                              ),
                              SizedBox(height: 20),
                        
                               TextFormField(
                                maxLines: 6,
                              
                               
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Write some text".tr;
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                           hintText: "Write here".tr,
                                ),
                                
                                onChanged: (value) {
                                  model.contactUs.message = value;
                                },
                              ),
                              SizedBox(height: 50.h),
                              GestureDetector(
                        onTap: () {
                          if (formKey.currentState!
                              .validate()) {
                        
                          model.addContactUsRecord();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Text("Submit", style: buttonTextStyle.copyWith(
                            color: Colors.white,
                          )),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}