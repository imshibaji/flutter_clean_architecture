import 'package:flutter/material.dart';

import '../core/core.dart';
import '../features/lead_mod/lead_app.dart';
import '../features/main_app/app.dart';

// ignore: must_be_immutable
class ActionTopButtons extends ActionButtons {
  ActionTopButtons({Key? key})
      : super(key: key, buttonDatas: [
          ButtonData(
            icon: Icons.home,
            label: 'Main App',
            link: App.home,
          ),
          ButtonData(
            icon: Icons.people,
            label: 'Leads App',
            link: LeadApp.home,
          ),
          ButtonData(
            icon: Icons.logout,
            label: 'Logout',
            link: '/logout',
          ),
        ]);
}
