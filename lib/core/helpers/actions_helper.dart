import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../core.dart';

List<Widget> actionsMenu(
  BuildContext context, {
  List<Widget> preActions = const [],
  List<Widget> postActions = const [],
}) {
  return [
    ...ActionTopButtons.getPreAcction(context).toList(),
    if (ActionTopButtons.dayNightSwitch) const DayNightSwitch(),
    ...ActionTopButtons.getPostAcction(context).toList(),
  ];
}

List<Widget> actionsMenuWithDropdowns(BuildContext context) {
  return [
    IconButton(
        onPressed: () {
          Nav.to(context, '/profile');
        },
        icon: const Icon(Icons.account_circle_outlined)),
    const DayNightSwitch(),
    ActionTopButtons()
  ];
}

List<Widget> actionsMenuWithLogout(BuildContext context) {
  return [
    IconButton(
        onPressed: () {
          Nav.to(context, '/profile');
        },
        icon: const Icon(Icons.account_circle_outlined)),
    const DayNightSwitch(),
    IconButton(
      onPressed: () {
        doLogout(context);
      },
      icon: const Icon(Icons.logout),
    ),
  ];
}
