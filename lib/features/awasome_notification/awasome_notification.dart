import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'awasome_notification_service.dart';

class AwasomeNotificationUi extends StatefulWidget {
  const AwasomeNotificationUi({Key? key}) : super(key: key);

  @override
  State<AwasomeNotificationUi> createState() => _AwasomeNotificationUiState();
}

class _AwasomeNotificationUiState extends State<AwasomeNotificationUi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awasome Notification'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                AppButton(
                  label: 'Simple Notfication',
                  onPressed: () {
                    AwasomeNotificationService().showNotification();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Followup Notfication',
                  onPressed: () {
                    AwasomeNotificationService().showActivitypNotification(
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
                  label: 'Icon Notfication',
                  onPressed: () {
                    AwasomeNotificationService().showNotificationWithIcon();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Image Notfication',
                  onPressed: () {
                    AwasomeNotificationService().showNotificationWithImage();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Scheduled Notfication',
                  onPressed: () {
                    AwasomeNotificationService().showScheduledNotify();
                  },
                  stretch: true,
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Remove Notfication',
                  onPressed: () {
                    AwasomeNotificationService().canceled();
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
