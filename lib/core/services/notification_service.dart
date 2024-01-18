import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/models/notifications.dart';
import 'package:f2_base_project/ui/screens/notification/notification-screen.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class NotificationsService {
  var _fcm = FirebaseMessaging.instance;
//   final _dbService = locator<DatabaseService>();
  // String? hostUserId;
// this string will hold the fcm token
  String? fcmToken;
// /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.',
      // description
      importance: Importance.high,
      playSound: true);

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //This behaviouSubject instance is for listening purpose in ios either the fuction is recieved or not
  //or if recieved then what event u want to trigger
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  NotificationsService() {
    initConfigure();
  }

  ///
  /// show local notificaiton
  showLocalNotificaiton(String number) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('ST001', 'Android',
            // 'Channel',
            priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      'Order Placed Success',
      'Your order has been placed successfully',
      platformChannelSpecifics,
    );
  }

  ///
  ///Initializing Notifiication services that includes FLN, ANDROID NOTIFICATION CHANNEL setting
  ///FCM NOTIFICATION SETTINGS, and also listeners for OnMessage and for onMessageOpenedApp
  ///
  initConfigure() async {
    try {
      print("@initFCMConfigure/started");
      // await initFlutterLocalNotificationPlugin();
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      _moveToTheRespectiveScreen(Notifications notifications) {
        Get.to(() => NotificationScreen());
      }

      // _handleNotification(RemoteMessage message, bool isOnMessage) {
      //   // final Notifications notification =
      //   //     Notifications.fromDirectJson(message.notification);
      //   print(notification.title);
      //   print(notification.content);

      //   if (isOnMessage) {
      //     Get.snackbar(
      //       notification.title!,
      //       notification.content!,
      //       backgroundColor: Colors.white,
      //       duration: Duration(seconds: 4),
      //       onTap: (data) {
      //         _moveToTheRespectiveScreen(notification);
      //       },
      //     );
      //   } else {
      //     _moveToTheRespectiveScreen(notification);
      //   }
      // }

      ///
      /// [onMessage] callback is called when the app is in foreground.
      ///
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final data = message.data;
        debugPrint('Got a new notification in the foreground now');
        debugPrint('@OnMessage==> Message: $message');
        debugPrint('@OnMessage==> title: ${message.notification!.title}');
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // channel.description,
                  priority: Priority.high,
                  color: primaryColor,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      });

      ///
      /// [onMessageOpenedApp] callback is called when notification is received
      /// in the background (Both when app is running in the background as well
      /// as terminated) and the notification is clicked from the notification tray.
      ///
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final data = message.data;
        debugPrint('Got a new notification in the foreground now');
        debugPrint('@onMessageOpenedApp==> Data: $data');
        Get.to(() => RootScreen());
        // if (message.notification != null) {
        //   debugPrint(
        //       '@OnMessage==> Notification: ${message.notification!.title}');
        //   Get.snackbar(
        //     '${message.notification!.title}',
        //     '${message.notification!.body!}',
        //     backgroundColor: Colors.white,
        //     duration: Duration(seconds: 4),
        //     onTap: (data) {
        //       Get.to(() => RootScreen());
        //     },
        //   );
        // }
        // RemoteNotification notification = message.notification!;
        // AndroidNotification android = message.notification!.android!;
        // print('A new onMessageOpenedApp event was published!');
        // if (notification != null && android != null) {
        //   flutterLocalNotificationsPlugin.show(
        //       notification.hashCode,
        //       notification.title,
        //       notification.body,
        //       NotificationDetails(
        //         iOS: IOSNotificationDetails(subtitle: channel.description),
        //         android: AndroidNotificationDetails(
        //           channel.id,
        //           channel.name,
        //           channel.description,
        //           // TODO add a proper drawable resource to android, for now using
        //           //      one that already exists in example app.
        //           icon: '@mipmap/ic_launcher',
        //         ),
        //       ));
        // }
      });
    } catch (e, s) {
      print(e);
      print(s);
    }
    print("@initConfigure/ENDED");
  }

  Future<void> sendPushMessage() async {
    if (fcmToken == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(fcmToken!),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
          await _fcm.subscribeToTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
          await _fcm.unsubscribeFromTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String? token = await _fcm.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
                'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }

// Crude counter to make messages unique
  int _messageCount = 0;

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(String token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  // sendNotification({
  //   hostFCMtoken,
  //   userName,
  //   hostUserId,
  //   carName,
  // }) async {
  //   final fcmToken = hostFCMtoken;
  //   // 'ef-KxIlWRcaQs4QSoYhCjk:APA91bGAoiPUOh-39DAhpoiPBZi9V7lJXhGXpikJnnbWzqIM_Lm4nKY_H2gdpV4EaEiMh_B5xnbEQQ07Fev-B5IA9hGiBPuliPv3qjcJVjYuTLKlRG4z_UCrnCkkjQPrG08jJQVKElKl';
  //   //fcmServerKey will remain same
  //   final fcmServerKey = '<YOUR_FCM_SERVER_KEY>';
  //   final dio = Dio();
  //   dio.options.headers['Content-Type'] = 'application/json';
  //   dio.options.headers["Authorization"] = 'key=$fcmServerKey';
  //   final sendFcmApi = 'https://fcm.googleapis.com/fcm/send';
  //   final response = await dio.post(
  //     '$sendFcmApi',
  //     data: {
  //       'notification': {
  //         'body': 'Has Booked your $carName car',
  //         'title': '$userName '
  //       },
  //       'priority': 'high',
  //       'data': {
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //         // 'type': '$callType', // audio_call, video_call,
  //         // 'patient_id': '$patientId',
  //         // 'conversation_id': '$conversationId',
  //         'hostUserId': '$hostUserId'
  //       },
  //       'to': '$fcmToken',
  //     },
  //   );

  //   print('@sendNotification: Response: $response');
  // }

  initFlutterLocalNotificationPlugin() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        // 'This channel is used for important notifications.',
        // description
        importance: Importance.high,
        playSound: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      ////
      ///ONNOTIFICATION CLICK PAYLOAD IOS Configuration
      ///
      ///
      // final IOSInitializationSettings initializationSettingsIOS =
      //     IOSInitializationSettings(
      //   onDidReceiveLocalNotification: (id, title, body, payload) async {
      //     ReceivedNotification receivedNotification = ReceivedNotification(
      //         id: id, title: title, body: body, payload: payload);
      //     didReceivedLocalNotificationSubject.add(receivedNotification);
      //   },
      // );
      // final MacOSInitializationSettings initializationSettingsMacOS =
      //     MacOSInitializationSettings();
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        // iOS: initializationSettingsIOS,
      );
      ////
      ///ONNOTIFICATION CLICK PAYLOAD ANDROID
      ///

      // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      //     onSelectNotification: (payload) async {
      //   onNotificationClick(payload!);
      // });

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    //first instantiating the settings
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // print('User granted permission: ${settings.authorizationStatus}');
  }

  onNotificationClick(String payload) {
    print('Payload / notification data message is ====>  $payload');
    // Get.to(() => NotificationScreen2(hostUserId));
  }

  Future<String?> getFcmToken() async {
    return await _fcm.getToken();
  }
}

///
///recived notification model class for ios didNotificationRecieved callback
///
class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
