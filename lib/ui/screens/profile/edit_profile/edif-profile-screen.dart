import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/screens/profile/edit_profile/edit-profile-veiw-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final AppUser? userProfile;
  EditProfileScreen({this.userProfile});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isNmaeEdit = false;
  bool isEmailEdit = false;
  bool isMobileNoEdit = false;
  bool isdobEdit = false;
  bool isDataEdit = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileViewModel(widget.userProfile!),
      child: Consumer<EditProfileViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            progressIndicator: circularProgressIndicator(),
            inAsyncCall: model.state == ViewState.busy,
            child: BaseScreen(
              topPadding: 91,
              appBarChild: CustomAppBar(
                leadingIcon: '$staticAssets/back_icon.png',
                onLeadingPressed: () {
                  Get.back();
                },
                title: 'Edit Profile'.tr,
              ),

              ///
              ///[body]
              ///
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    //avatar for adding photo
                    addImage(model),

                    //user  prfole forms
                    userInfo(model),

                    //save button
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
                          title: 'Save'.tr,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (model.image != null) {
                                await model.updateUserAvatar();
                                if (isDataEdit) {
                                  await model.saveUserData();
                                  // Get.back(result: model.userProfileResponse.userProfile);
                                } else {
                                  // Get.back(result: model.userProfileResponse.userProfile);
                                }
                              } else {
                                if (isDataEdit) {
                                  await model.saveUserData();
                                  // Get.back(result: model.userProfileResponse.userProfile);
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  ///add image container
  ///
  addImage(EditProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 47.4,
        bottom: 79,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              model.getImage();
            },
            child: Container(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: model.image == null
                        ? widget.userProfile!.imageUrl == null
                            ? CircleAvatar(
                                radius: 55.r,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                  size: 45,
                                ),
                              )
                            : CircleAvatar(
                                radius: 55.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    '${widget.userProfile!.imageUrl}'),
                              )
                        : CircleAvatar(
                            radius: 55.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(model.image!),
                          ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ImageContainer(
                        assetImage: "$assets/camera.png",
                        width: 46.46.w,
                        height: 40.48.h,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  userInfo(EditProfileViewModel model) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 22.0, bottom: 65.4),
      child: Column(
        children: [
          isNmaeEdit
              ? editProfileData(
                  label: 'name'.tr,
                  hintText: 'full_name'.tr,
                  initialValue: '${model.editUserProfile.name}',
                  onChange: (value) {
                    model.editUserProfile.name = value;
                  })
              : tile(
                  label: "name".tr,
                  value: "${widget.userProfile!.name}",
                  onEditPressed: () {
                    setState(() {
                      isDataEdit = true;
                      isNmaeEdit = true;
                    });
                  }),
          isEmailEdit
              ? editProfileData(
                  label: 'location'.tr,
                  hintText: 'location'.tr,
                  initialValue: '${model.editUserProfile.location ?? ""}',
                  onChange: (value) {
                    model.editUserProfile.location = value;
                  })
              : tile(
                  label: "location".tr,
                  value: "${model.editUserProfile.location ?? ""}",
                  onEditPressed: () {
                    setState(() {
                      isDataEdit = true;
                      isEmailEdit = true;
                    });
                  }),
          isMobileNoEdit
              ? editProfileData(
                  label: 'mobile'.tr,
                  hintText: 'mobile'.tr,
                  textInputType: TextInputType.number,
                  initialValue: '${model.editUserProfile.mobileNo ?? ""}',
                  onChange: (value) {
                    model.editUserProfile.mobileNo = value;
                  })
              : tile(
                  label: "mobile".tr,
                  value: "${widget.userProfile!.mobileNo ?? ""}",
                  onEditPressed: () {
                    setState(() {
                      isDataEdit = true;
                      isMobileNoEdit = true;
                    });
                  }),
          tile(
              label: "gender".tr,
              isGender: true,
              model: model,
              onEditPressed: (newValue) {
                model.getGender(newValue);
                isDataEdit = true;
              }),
          tile(
              label: "Birthday".tr,
              value:
                  "${widget.userProfile!.dob == null ? ' ' : widget.userProfile!.dob}",
              onEditPressed: () {
                setState(() {
                  _selectDate(
                      context,
                      widget.userProfile!.dob == null
                          ? DateFormat("dd-MM-yyyy HH:mm:ss")
                              .parse('9-9-1970 00:00:00')
                          : DateFormat("dd-MM-yyyy HH:mm:ss")
                              .parse('${widget.userProfile!.dob} 00:00:00'),
                      model);
                });
              }),
        ],
      ),
    );
  }

  _selectDate(BuildContext context, DateTime? selectedDate,
      EditProfileViewModel model) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate!, // Refer step 1
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 3),
        builder: (context, child) {
          return Theme(
              data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    secondary: greyColor,
                    primary: primaryColor,
                    onPrimary: Colors.white,
                    surface: primaryColor,
                    onSurface: Colors.black,
                  ),
                  indicatorColor: primaryColor,
                  hintColor: primaryColor,
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(primary: primaryColor)),
                  dialogBackgroundColor: Colors.white),
              child: child!);
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        isDataEdit = true;
        model.editUserProfile.dob =
            '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}';
      });
  }

  editProfileData({label, hintText, initialValue, onChange, textInputType}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 26.1, top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$label: ",
                style: bodyTextStyleLato.copyWith(
                    fontSize: 20.sp, color: primaryColor),
              ),
              SizedBox(width: 30.w),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor.withOpacity(0),
                      ),
                    ),
                    TextFormField(
                      keyboardType: textInputType ?? TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "required_field".tr;
                        } else {
                          return null;
                        }
                      },
                      onChanged: onChange,
                      initialValue: '$initialValue',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12, bottom: 8),
                        hintText: '$hintText',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.4,
        ),
      ],
    );
  }

  tile(
      {label,
      value,
      onEditPressed,
      isGender = false,
      EditProfileViewModel? model}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 26.1, top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$label",
                style: bodyTextStyleLato.copyWith(
                    fontSize: 20.sp, color: primaryColor),
              ),
              isGender
                  ? //custom drop down
                  Container(
                      height: 30.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 9,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        color: primaryColor,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: primaryColor.withOpacity(0.9),
                          style: bodyTextStyleLato.copyWith(
                              color: primaryColor,
                              letterSpacing: 0,
                              fontSize: 16),
                          value: model!.editUserProfile.gender,
                          icon: Icon(Icons.keyboard_arrow_down,
                              size: 15, color: Colors.white),
                          elevation: 0,
                          onChanged: onEditPressed,
                          items: <String>['Male', 'Female',"Prefer not to disclose"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: bodyTextStyleLato.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0,
                                    fontSize: 16.sp),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          "$value",
                          style: bodyTextStyleLato.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(
                          width: 12.5.w,
                        ),
                        GestureDetector(
                          onTap: onEditPressed,
                          child: Image.asset(
                            "$assets/edit.png",
                            scale: 4,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
        Divider(
          thickness: 0.4,
        ),
      ],
    );
  }

  // saveButton(EditProfileViewModel model) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 55.8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 40.94.h,
  //           width: 158.w,
  //           child: RoundedRaisedButton(
  //             text: "save".tr,
  //             onPressed: () async {
  //               if (_formKey.currentState!.validate()) {
  //                 if (model.image != null) {
  //                   await model.updateUserAvatar();
  //                   if (isDataEdit) {
  //                     await model.saveUserData();
  //                     // Get.back(result: model.userProfileResponse.userProfile);
  //                   } else {
  //                     // Get.back(result: model.userProfileResponse.userProfile);
  //                   }
  //                 } else {
  //                   if (isDataEdit) {
  //                     await model.saveUserData();
  //                     // Get.back(result: model.userProfileResponse.userProfile);
  //                   }
  //                 }
  //               }
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  _topAppBar() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Get.locale!.languageCode == 'ar'
                ? Matrix4.rotationY(pi)
                : Matrix4.rotationY(0),
            child: ImageContainer(
              assetImage: "$assets/back_white.png",
              height: 22.h,
              width: 11.w,
            ),
          ),
        ),
        SizedBox(
          width: 24.w,
        ),
        Text(
          "edit_profile".tr,
          style:
              bodyTextStyleLato.copyWith(color: Colors.white, fontSize: 20.sp),
        )
      ],
    );
  }
}
