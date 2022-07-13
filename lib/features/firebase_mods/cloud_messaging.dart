import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../awesome_notification/awesome_notification_service.dart';

class CloudMessaging {
  static init() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
    // getToken();
  }

  static getToken() async {
    return await FirebaseMessaging.instance
        .getToken()
        .then((value) => log(value!));
  }

  static listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      log(message.notification!.title! + ',  ' + message.notification!.body!);
      // print(message.data);

      AwesomeNotificationService().showFCM(
        notification!.title!,
        notification.body!,
      );
    });
  }

  static listenFCBM() async {
    // await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }
}
