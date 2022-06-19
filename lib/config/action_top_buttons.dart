import 'package:flutter/material.dart';

import '../core/core.dart';
import '../features/lead_mod/lead_app.dart';
// import '../features/main_app/app.dart';

// ignore: must_be_immutable
class ActionTopButtons extends ActionButtons {
  static const bool dayNightSwitch = true;

  ActionTopButtons({Key? key})
      : super(
          key: key,
          buttonDatas: [
            ButtonData(
              icon: Icons.business,
              label: 'Business Details',
              link: LeadApp.businessPage,
            ),
            ButtonData(
              icon: Icons.person,
              label: 'Owner Profile',
              link: LeadApp.profile,
            ),
            // ButtonData(
            //   icon: Icons.notifications,
            //   label: 'Awasome Notifications',
            //   link: AwasomeNotificationApp.home,
            // ),
            // ButtonData(
            //   icon: Icons.help_outline_sharp,
            //   label: 'Helps & Tutorials',
            //   link: LeadApp.helpPage,
            // ),
            // ButtonData(
            //   icon: Icons.settings_applications_outlined,
            //   label: 'Settings',
            //   link: LeadApp.settings,
            // ),
            // ButtonData(
            //   icon: Icons.logout,
            //   label: 'Logout',
            //   link: '/logout',
            // ),
          ],
        );

  static List<Widget> getPreAcction(BuildContext context) {
    return [
      // IconButton(
      //   onPressed: () {
      //     Nav.to(context, '/business');
      //   },
      //   icon: const Icon(Icons.business),
      // ),
      // IconButton(
      //   onPressed: () {
      //     Nav.to(context, '/help');
      //   },
      //   icon: const Icon(Icons.help_outline),
      // ),
    ];
  }

  static List<Widget> getPostAcction(BuildContext context) {
    final atb = ActionTopButtons();
    return [
      atb.getMenuDropdown(context),
    ];
  }
}
