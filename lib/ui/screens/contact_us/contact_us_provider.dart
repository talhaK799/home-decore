import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/contsct_us.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/locator.dart';
import 'package:get/get.dart';

class ContactUsProvider extends BaseViewModel{
  ContactUs contactUs = ContactUs();
  final _currentuser = locator<AuthService>();
  final _dbService = DatabaseService();


  addContactUsRecord()async{
    setState(ViewState.busy);
    contactUs.user_id = _currentuser.appUser.id;
    contactUs.createdAt = DateTime.now();
   bool isAdded =  await _dbService.addContactUsRecord(contactUs);

    setState(ViewState.idle);

    if(isAdded){
      Get.snackbar("Success!!", "Request added successflully");
    }else{
      Get.snackbar("Errro!!", "Something went wrong please try again");
    }
  }

}