import 'package:f2_base_project/core/models/language.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';

class LanguageSettingsViewModel extends BaseViewModel{

  List<Language> languages = [
    Language(
      title: "English",
      isSelected: false,
      id: "abc",
      code: "en",
    ),
    Language(
      title: "French",
      isSelected: false,
      id: "abc",
      code: "fr",
    ),
    Language(
      title: "Netherlands",
      isSelected: false,
      id: "abc",
      code: "ne",
    ),
  ];

  String code = 'en';

  LanguageSettingsViewModel(){
    init();
  }


  init(){
    for (var i = 0; i < languages.length; i++) {
      if(languages[i].code==code){
        languages[i].isSelected=true;
      }else{
        languages[i].isSelected=false;
      }
      notifyListeners();
      
    }

  }


  selectLanguage(index){
    print("index ==> $index");
    for (var i = 0; i < languages.length; i++) {
      if(i==index){
        languages[i].isSelected=true;
      }else{
        languages[i].isSelected=false;
      }
      notifyListeners();
      
    }
    notifyListeners();

  }


  

}