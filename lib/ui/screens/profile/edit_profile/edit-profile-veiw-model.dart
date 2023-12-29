import 'dart:io';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/core/services/file_picker_service.dart';
import 'package:f2_base_project/core/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../locator.dart';

class EditProfileViewModel extends BaseViewModel {
  File? image;
  final _dbService = locator<DatabaseService>();
  final _authSerivce = locator<AuthService>();
  StorageService _storageService = StorageService();
  final picker = ImagePicker();
  AppUser editUserProfile = AppUser();
  FilePickerService filePickerService = FilePickerService();
  EditProfileViewModel(AppUser userProfile) {
    editUserProfile = userProfile;
  }

  saveUserData() async {
    setState(ViewState.busy);
    // if (image != null) {
    //   await updateUserAvatar();
    // }
    bool isUpdatd =
        await _dbService.updateUser(editUserProfile, _authSerivce.appUser.id);
    Get.back();
    setState(ViewState.idle);
    if (isUpdatd == true) {
      Get.snackbar("success".tr, "profile_updated_successfully".tr);
    } else {
      Get.snackbar("error".tr, "something_went_wrong".tr);
    }
  }

  updateUserAvatar() async {
    setState(ViewState.busy);
    editUserProfile.imageUrl =
        await _storageService.uploadImage(image!, 'profile_images');
    print('imageUrl => ${editUserProfile.imageUrl}');
    setState(ViewState.idle);
  }

  void getGender(String newValue) {
    editUserProfile.gender = newValue;
    notifyListeners();
  }

  Future getImage() async {
    setState(ViewState.busy);
    final pickedImage = await filePickerService.pickImageWithoutCompression();
    if (pickedImage != null) {
      image = File(pickedImage.path);
    } else {
      print('No image selected.');
    }
    setState(ViewState.idle);
  }
}
