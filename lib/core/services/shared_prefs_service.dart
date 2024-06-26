import 'package:f2_base_project/core/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  var sharedPrefsRef;

  String language = 'en';

  SharedPrefsService() {
    init();
  }

  init() async {
    if (sharedPrefsRef == null) {
      sharedPrefsRef = await SharedPreferences.getInstance();
    }
    getSelectedLanguage();
  }

  ///
  /// Onboarding settings
  ///
  getOnboardingPageCount() async {
    await init();
    int count = sharedPrefsRef.getInt('onBoardingCount') ?? 0;
    return count;
  }

  Future<bool> setOnboardingPageCount(int count) async {
    await init();
    final status = await sharedPrefsRef.setInt('onBoardingCount', count);
    return status;
  }

  Future<int> getNotificationCount() async {
    await init();
    int count = sharedPrefsRef.getInt('notificationsCount') ?? 0;
    return count;
  }

  ///
  /// Notification settigns
  ///
  Future<bool> updateNotificationsCount(int count) async {
    await init();
    final status = await sharedPrefsRef.setInt('notificationsCount', count);
    return status;
  }

  ///
  /// Authentication settings
  ///
  saveAccessToken(String token) async {
    await init();
    await sharedPrefsRef.setString('access_token', token);
  }

  clearAccessToken() async {
    await init();
    await sharedPrefsRef.setString('access_token', empty);
  }

  Future<String> getAccessToken() async {
    await init();
    return sharedPrefsRef.getString("access_token") ?? empty;
  }

  saveRefreshToken(String userId) async {
    await init();
    await sharedPrefsRef.setString('refresh_token', userId);
  }

  clearRefreshToken() async {
    await init();
    await sharedPrefsRef.setString('refresh_token', empty);
  }

  Future<String> getRefreshToken() async {
    await init();
    return sharedPrefsRef.getString("refresh_token");
  }

  ///
  /// FCM notification settings
  ///

  saveFcmToken(String userId) async {
    await init();
    await sharedPrefsRef.setString('fcm_token', userId);
  }

  clearFcmToken() async {
    await init();
    await sharedPrefsRef.setString('fcm_token', null);
  }

  Future<String> getFcmToken() async {
    await init();
    return sharedPrefsRef.getString("fcm_token");
  }

  updateNotificationStatus(bool value) async {
    await init();
    await sharedPrefsRef!.setBool('notification_status', value);
  }

  Future<bool> getNotificationSatus() async {
    await init();
    return sharedPrefsRef!.getBool("notification_status") ?? true;
  }

  ///
  /// Language
  ///

  updateSelectedLanguage(String langCode) async {
    // await init();
    await sharedPrefsRef!.setString('lang_code', langCode);
    getSelectedLanguage();
  }

  getSelectedLanguage() async {
    // await init();

    language = await sharedPrefsRef!.getString("lang_code") ?? 'en';
    print("Languages ======>>>$language");
  }
}
