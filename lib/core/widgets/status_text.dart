import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StatusText extends StatelessWidget {
  String label;
  double? size;
  StatusText({Key? key, required this.label, this.size = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: (label == 'new')
            ? Colors.blue
            : (label == 'pending')
                ? Colors.orange
                : (label == 'processing')
                    ? Colors.greenAccent
                    : (label == 'success')
                        ? Colors.green.shade600
                        : (label == 'rejected')
                            ? Colors.red.shade800
                            : Colors.blue.shade800,
        fontSize: size,
      ),
    );
  }
}
