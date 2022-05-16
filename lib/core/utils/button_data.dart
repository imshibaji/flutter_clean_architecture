import 'package:flutter/material.dart';

class ButtonData {
  IconData icon;
  String label;
  String? link;
  ButtonData({
    required this.icon,
    required this.label,
    this.link,
  });
}
