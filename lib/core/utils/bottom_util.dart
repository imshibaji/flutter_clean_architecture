import 'package:flutter/material.dart';

import '../../config/config.dart';

BottomNavigationBarItem bottomNavigationBarItem({
  required Widget icon,
  String? label,
  Color? backgroundColor,
}) {
  return BottomNavigationBarItem(
    icon: icon,
    label: label,
    backgroundColor: backgroundColor ?? AppColors.teal,
  );
}
