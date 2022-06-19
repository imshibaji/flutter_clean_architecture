import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import '../lead_mod/utils/utils.dart';
import 'package:flutter/material.dart';

class AwasomeNotificationService {
  static final AwasomeNotificationService _notificationService =
      AwasomeNotificationService._internal();

  factory AwasomeNotificationService() {
    return _notificationService;
  }

  AwasomeNotificationService._internal();

  Future<void> initAwasomeNotification() async {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
          channelGroupKey: 'leadbook_channel_group',
          channelKey: 'leadbook_channel',
          channelName: 'Leads notifications',
          channelDescription: 'Notification channel for LeadBook',
          defaultColor: Colors.teal,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupkey: 'leadbook_channel_group',
          channelGroupName: 'LeadBook Notifications',
        )
      ],
      debug: false,
    );
    permissionCheck();
  }

  listenActionStream() {
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {
      final data = jsonDecode(receivedNotification.toString());
      // log(receivedNotification.toMap().toString());
      // log(data['buttonKeyPressed']);
      log(data['payload'].toString());
      if (data['buttonKeyPressed'] == 'CALL') {
        makePhoneCall(data['payload']['mobile']);
      }
      if (data['buttonKeyPressed'] == 'EMAIL') {
        mailTo(data['payload']['email']);
      }
    });
  }

  permissionCheck() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  showNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.bitLength,
        channelKey: 'leadbook_channel',
        title: 'Title for your notification',
        body: 'body text/ content',
        // notificationLayout: NotificationLayout.Default,
        payload: {
          'mobile': '8981009499',
          'email': 'imshibaji@gmail.com',
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'CALL',
          label: 'Call',
        ),
        NotificationActionButton(
          key: 'EMAIL',
          label: 'Email',
        ),
      ],
    );
  }

  showActivitypNotification(
    String title,
    String body, {
    Map<String, String>? payload,
    DateTime? schedule,
    String timeZone = 'asia/kolkata',
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.bitLength,
        channelKey: 'leadbook_channel',
        title: title,
        body: body,
        // notificationLayout: NotificationLayout.Default,
        payload: payload,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'CALL',
          label: 'Call',
        ),
        NotificationActionButton(
          key: 'EMAIL',
          label: 'Email',
        ),
      ],
      schedule: NotificationCalendar.fromDate(
        date: schedule ?? DateTime.now(),
      ),
    );
  }

  showNotificationWithIcon() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      //simgple notification
      id: DateTime.now().millisecondsSinceEpoch.bitLength,
      channelKey: 'basic_channel', //set configuration wuth key "basic"
      title: 'Welcome to FlutterCampus.com',
      body: 'This simple notification is from Flutter App',
      // largeIcon: 'asset://assets/images/dj-disc.jpg',
      //large icon will be displayed at right side
    ));
  }

  showNotificationWithImage() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.bitLength,
        channelKey: 'basic_channel',
        title: 'This is Notification title',
        body: 'This is Body of Noti',
        bigPicture:
            'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  void showScheduledNotify() async {
    String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.bitLength,
        channelKey: 'basic_channel',
        title: 'This is Scheduled Notification',
        body: 'This is The Schedules notification Body',
        bigPicture:
            'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
      schedule: NotificationInterval(
        interval: 2,
        timeZone: timezom,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
    );
  }

  canceled() {
    AwesomeNotifications().dismissAllNotifications();
  }
}
