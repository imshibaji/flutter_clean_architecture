import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import 'status_text.dart';

// ignore: must_be_immutable
class ChipButton extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  double? paddingValue, circularValue, marginValue;
  String label;
  Function() onPressed;
  bool? stretch;

  ChipButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.marginValue = 0.3,
    this.paddingValue = 0.0,
    this.circularValue = 0.0,
    this.stretch = false,
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
            child: StatusText(
              label: label,
            ),
            style: ElevatedButton.styleFrom(
              primary: backgroundColor ??
                  (tm.isDarkMode
                      ? const Color.fromARGB(255, 2, 61, 55).withOpacity(0.3)
                      : const Color.fromARGB(255, 227, 253, 250)
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
          child: StatusText(
            label: label,
          ),
          style: ElevatedButton.styleFrom(
            primary: backgroundColor ??
                (tm.isDarkMode
                    ? const Color.fromARGB(255, 2, 61, 55).withOpacity(0.3)
                    : const Color.fromARGB(255, 227, 253, 250)
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

    // return ElevatedButton(
    //   onPressed: onPressed,
    //   child: StatusText(
    //     label: label,
    //   ),
    //   style: ElevatedButton.styleFrom(
    //     primary: backgroundColor,
    //     onPrimary: textColor,
    //     padding: EdgeInsets.all(paddingValue!),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(circularValue!),
    //     ),
    //   ),
    // );
  }
}
