import 'package:flutter/material.dart';

import '../../../core/utils/button_data.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../lead_mod.dart';

// ignore: must_be_immutable
class LeadAppBottomBar extends BottomBar {
  LeadAppBottomBar({Key? key})
      : super(key: key, buttonDatas: [
          ButtonData(
            icon: Icons.dashboard,
            label: 'Dashboard',
            link: LeadApp.home,
          ),
          ButtonData(
            icon: Icons.task_alt,
            label: 'Followup',
            link: LeadApp.followup,
          ),
          ButtonData(
            icon: Icons.search_rounded,
            label: 'Search',
            link: LeadApp.search,
          ),
        ]);
}
