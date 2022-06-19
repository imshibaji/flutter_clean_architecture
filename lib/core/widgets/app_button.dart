import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  String label;
  double? paddingValue, circularValue, marginValue;
  void Function() onPressed;
  bool? stretch;

  AppButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    required this.label,
    this.paddingValue = 8.0,
    this.marginValue = 0.0,
    required this.onPressed,
    this.stretch = false,
    this.circularValue = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tm = context.watch<ThemeProvider>();
    if (stretch == true) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.all(marginValue!),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              primary: backgroundColor ??
                  (tm.isDarkMode
                      ? const Color.fromARGB(255, 193, 253, 247)
                          .withOpacity(0.2)
                      : const Color.fromARGB(255, 248, 255, 254)
                          .withOpacity(1.0)),
              onPrimary: textColor,
              padding: EdgeInsets.all(paddingValue!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circularValue!),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(marginValue!),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: backgroundColor ??
                (tm.isDarkMode
                    ? const Color.fromARGB(255, 193, 253, 247).withOpacity(0.2)
                    : const Color.fromARGB(255, 248, 255, 254)
                        .withOpacity(1.0)),
            onPrimary: textColor,
            padding: EdgeInsets.all(paddingValue!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularValue!),
            ),
          ),
        ),
      );
    }
  }
}
