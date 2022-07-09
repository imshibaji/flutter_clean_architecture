import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'awesome_notification_service.dart';

class AwesomeNotificationUi extends StatefulWidget {
  const AwesomeNotificationUi({Key? key}) : super(key: key);

  @override
  State<AwesomeNotificationUi> createState() => _AwesomeNotificationUiState();
}

class _AwesomeNotificationUiState extends State<AwesomeNotificationUi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Notification'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                AppButton(
                  label: 'Simple Notification',
                  onPressed: () {
                    AwesomeNotificationService().showNotification();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Followup Notification',
                  onPressed: () {
                    AwesomeNotificationService().showActivityNotification(
                      'Followup Activity:',
                      'Do it Now.',
                    );
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Icon Notification',
                  onPressed: () {
                    AwesomeNotificationService().showNotificationWithIcon();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Image Notification',
                  onPressed: () {
                    AwesomeNotificationService().showNotificationWithImage();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Scheduled Notification',
                  onPressed: () {
                    AwesomeNotificationService().showScheduledNotify();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Remove Notification',
                  onPressed: () {
                    AwesomeNotificationService().canceled();
                  },
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
