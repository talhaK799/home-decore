import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/models/notifications.dart';
import 'package:f2_base_project/core/services/language_service.dart';
import 'package:f2_base_project/core/services/shared_prefs_service.dart';
import 'package:f2_base_project/locator.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_view_model.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_view_model.dart';
import 'package:f2_base_project/ui/screens/home/home_view_model.dart';
import 'package:f2_base_project/ui/screens/notification/notification-screen.dart';
import 'package:f2_base_project/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'rooter.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // await Firebase.initializeApp();
    await setupLocator();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // final _notificationsService = locator<NotificationsService>();
    // await _notificationsService.initConfigure();
    final langCode = 'en';
// await locator<SharedPrefsService>().getSelectedLanguage();
    runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(langCode), // Wrap your app
  ),);
  } catch (e, s) {
    print("$e");
    print("$s");
  }
}

class MyApp extends StatefulWidget {
  final langCode;
  MyApp(this.langCode) {
    // print("Selected language code is: $langCode");
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localStorage = locator<SharedPrefsService>();
  @override
  void initState() {
    super.initState();
    // _getLang();
  }

  // _getLang() {
  //   setState(() {
  //     localStorage.getSelectedLanguage();
  //   });
  // }

  _moveToTheRespectiveScreen(Notifications notification) {
    Get.to(() => NotificationScreen());
  }

  _handleNotification(RemoteMessage message) {
    final Notifications notification =
        Notifications.fromJson(message.data, 'id');
    _moveToTheRespectiveScreen(notification);
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleNotification(initialMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print(screenSize);
  
    return MediaQuery(
      data: MediaQueryData(size: Size(screenSize.width, screenSize.height)),
      child: ScreenUtilInit(
        designSize: Size(screenSize.width, screenSize.height),
        builder: (context, child) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartViewModel(this)),
            ChangeNotifierProvider(create: (context) => LoginViewModel()),
            ChangeNotifierProvider(create: (context) => HomeViewModel()),
          ],
          child: GetMaterialApp(
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            title: "Inna Home",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Rooter.generateRoute,
            translations: Languages(),
            locale: Locale(localStorage.language),
            fallbackLocale: Locale(localStorage.language),
            theme: ThemeData(
              primaryColor: primaryColor,
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          ),
        ),
      ),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("@firebaseMessagingBackgroundHandler");
  // print(
  //     '@onBackgroundMessageHanlder ==> Notification: ${message.notification}');
  // print('@onBackgroundMessageHanlder ==> Data: ${message.data}');
}
