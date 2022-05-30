import 'status_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChipButton extends StatelessWidget {
  String label;
  Function() onPressed;
  ChipButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: StatusText(
        label: label,
      ),
    );
  }
}
