import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  String label;
  double? paddingValue;
  void Function() onPressed;
  bool? stretch;

  AppButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    required this.label,
    this.paddingValue = 8.0,
    required this.onPressed,
    this.stretch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stretch == true) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              padding: EdgeInsets.all(paddingValue!),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: EdgeInsets.all(paddingValue!),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }
  }
}
