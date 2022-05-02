import 'package:clean_archetructure/core/helpers/login_helper.dart';
import 'package:clean_archetructure/core/widgets/day_night_switch.dart';
import 'package:flutter/material.dart';

List<Widget> actionsMenu(BuildContext context) {
  return [
    const DayNightSwitch(),
    IconButton(
      onPressed: () {
        doLogout(context);
      },
      icon: const Icon(Icons.logout),
    )
  ];
}
