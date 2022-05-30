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
        color: (label.toLowerCase() == 'new')
            ? Colors.blue
            : (label.toLowerCase() == 'pending')
                ? Colors.orange
                : (label.toLowerCase() == 'processing' ||
                        label.toLowerCase() == 'interested')
                    ? const Color.fromARGB(255, 199, 173, 6)
                    : (label.toLowerCase() == 'success' ||
                            label.toLowerCase() == 'income')
                        ? Colors.green.shade600
                        : (label.toLowerCase() == 'rejected' ||
                                label.toLowerCase() == 'expense')
                            ? Colors.red.shade800
                            : Colors.blue.shade800,
        fontSize: size,
      ),
    );
  }
}
