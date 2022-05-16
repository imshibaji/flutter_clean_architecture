import 'package:flutter/material.dart';

import '../../../core/utils/button_data.dart';
import '../../../core/widgets/bottom_bar.dart';

// ignore: must_be_immutable
class LeadAppBottomBar extends BottomBar {
  LeadAppBottomBar({Key? key})
      : super(key: key, buttonDatas: [
          ButtonData(icon: Icons.dashboard, label: 'Dashboard', link: '/'),
          ButtonData(
              icon: Icons.app_registration, label: 'About', link: '/about'),
        ]);
}
