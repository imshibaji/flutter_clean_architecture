import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../lead_mod/dbobj/dbobjs.dart';
import '../lead_mod/lead_app.dart';
import '../lead_mod/providers/providers.dart';
import '../lead_mod/services/services.dart';
import '../lead_mod/utils/utils.dart';

class AwesomeNotificationService {
  final cron = Cron();
  static final AwesomeNotificationService _notificationService =
      AwesomeNotificationService.awesomeNotificationService();

  factory AwesomeNotificationService() {
    return _notificationService;
  }

  AwesomeNotificationService.awesomeNotificationService();

  Future<void> initAwesomeNotification() async {
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
          enableVibration: true,
          enableLights: true,
          criticalAlerts: true,
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
      dev.log(receivedNotification.toMap().toString());
      // log(data['buttonKeyPressed']);
      dev.log(data['payload'].toString());
      if (data['buttonKeyPressed'] == 'CALL') {
        makePhoneCall(data['payload']['mobile']);
      }
      if (data['buttonKeyPressed'] == 'EMAIL') {
        mailTo(data['payload']['email']);
      }
      if (data['payload']['type'] == 'LEAD') {
        ServiceProvider sp = ServiceProvider();
        if (sp.leads != null && sp.leads!.isNotEmpty) {
          Lead lead = sp.leads!
              .where((element) => element.uid == data['payload']['id'])
              .first;
          Nav.go(LeadApp.viewLead, arguments: lead);
        }
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

  showFCM(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.bitLength,
        channelKey: 'leadbook_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
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

  showActivityNotification(
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
      //simple notification
      id: DateTime.now().millisecondsSinceEpoch.bitLength,
      channelKey: 'leadbook_channel', //set configuration with key "basic"
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
        channelKey: 'leadbook_channel',
        title: 'This is Notification title',
        body: 'This is Body of Notification',
        bigPicture:
            'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  void showScheduledNotify() async {
    String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.bitLength,
        channelKey: 'leadbook_channel',
        title: 'This is Scheduled Notification',
        body: 'This is The Schedules notification Body',
        bigPicture:
            'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
      schedule: NotificationInterval(
        interval: 2,
        timeZone: timezone,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
    );
  }

  goodMorningNotify() async {
    List<String> goodMorningMessages = [
      '“If you can dream it, you can achieve it.” – Zig Ziglar',
      '“The only way to do great work is to love what you do.”- Steve Jobs',
    ];

    var msg = goodMorningMessages[Random().nextInt(goodMorningMessages.length)];
    DateTime time = DateTime.now();
    DateTime fromTime =
        DateTime(time.year, time.month, time.day, 21, 0); // Every day Night 9PM
    var msgId = 1;
    dev.log(msg);
    dev.log(msgId.toString());

    urgentNotify(
      title: 'Good Morning',
      msgId: msgId,
      msg: msg,
      fromTime: fromTime,
      type: 'good_morning',
    );
  }

  goodNightNotify() async {
    List<String> goodMorningMessages = [
      '“Everything I do, I do it for you.” – Bryan Adams',
      '“I can’t close my eyes without you in my dreams.” – Luke Bryan',
    ];
    // String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    var msg = goodMorningMessages[Random().nextInt(goodMorningMessages.length)];
    DateTime time = DateTime.now();
    DateTime fromTime =
        DateTime(time.year, time.month, time.day, 21, 0); // Every day Night 9PM
    var msgId = 2;
    // dev.log(msg);
    // dev.log(msgId.toString());

    urgentNotify(
      title: 'Good Night',
      msgId: msgId,
      msg: msg,
      fromTime: fromTime,
      type: 'good_night',
    );
  }

  followupNotify() async {
    var pendings = FollowupService()
        .getAll()
        .where((element) => element.isDone == false)
        .toList()
        .length;

    if (pendings > 0) {
      cron.schedule(Schedule(hours: [12]), () {
        var msg = 'You have $pendings is pending.';
        var msgId = 3;
        cron.close();
        urgentNotify(
          title: 'Followup Notification',
          msgId: msgId,
          msg: msg,
          type: 'followup',
        );
      });
    }
  }

  dealNotify() async {
    try {
      var pendings = DealService()
          .getAll()
          .where((element) => element.status!.toLowerCase() == 'pending')
          .toList()
          .length;
      if (pendings > 0) {
        cron.schedule(Schedule(hours: [16]), () {
          var msg = 'You have $pendings is pending.'; // Every day Night 9PM
          var msgId = 4;
          cron.close();
          urgentNotify(
            title: 'Deal Notification',
            msgId: msgId,
            msg: msg,
            type: 'deal',
          );
        });
      }
    } catch (e) {
      cron.close();
    }
  }

  urgentNotify({
    int msgId = 41,
    String title = 'Urgent',
    String msg = 'Urgent Notification',
    DateTime? fromTime,
    String type = 'urgent',
    int? interval,
    bool repeats = false,
    bool allowWhileIdle = true,
    bool preciseAlarm = true,
  }) async {
    String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: msgId,
        channelKey: 'leadbook_channel',
        title: title,
        body: msg,
        notificationLayout: NotificationLayout.Default,
        payload: {'MSGID': msgId.toString(), 'MSG': msg, 'TYPE': type},
      ),
      schedule: fromTime == null
          ? NotificationInterval(
              interval: interval ?? Random().nextInt(10),
              timeZone: timezone,
              allowWhileIdle: allowWhileIdle,
              preciseAlarm: preciseAlarm,
              repeats: repeats,
            )
          : NotificationCalendar.fromDate(
              date: fromTime,
              repeats: repeats,
              allowWhileIdle: allowWhileIdle,
              preciseAlarm: preciseAlarm,
            ),
    );
  }

  cancelBy(int id) {
    AwesomeNotifications().cancel(id);
  }

  canceled() {
    AwesomeNotifications().dismissAllNotifications();
  }
}
