import 'package:clean_archetructure/config/app_colors.dart';
import 'package:flutter/material.dart';

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
