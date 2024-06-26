import 'package:f2_base_project/core/models/language.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/shared_prefs_service.dart';
import 'package:f2_base_project/locator.dart';

class LanguageSettingsViewModel extends BaseViewModel {
  final localStorage = locator<SharedPrefsService>();
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

  // String code = 'en';

  LanguageSettingsViewModel() {
    // getCode();
    init();
  }

  String code = '';

  // getCode() async {
  //   code = await localStorage.getSelectedLanguage();
  // }

  init() async {
    code = await localStorage.language ?? 'en';
    for (var i = 0; i < languages.length; i++) {
      if (languages[i].code == code) {
        languages[i].isSelected = true;
      } else {
        languages[i].isSelected = false;
      }
      // notifyListeners();
    }

    notifyListeners();
  }

  selectLanguage(index) {
    print("index ==> $index");
    for (var i = 0; i < languages.length; i++) {
      if (i == index) {
        localStorage.updateSelectedLanguage(languages[i].code!);
        languages[i].isSelected = true;
        notifyListeners();
        // await
        //     .updateSelectedLanguage(languages[i].code!);
      } else {
        languages[i].isSelected = false;
      }
      // notifyListeners();
    }
    notifyListeners();
  }
}
