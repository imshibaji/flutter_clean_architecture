import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';

// ignore: must_be_immutable
class StatusText extends StatelessWidget {
  String label;
  double? size;
  StatusText({Key? key, required this.label, this.size = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tp = context.watch<ThemeProvider>();
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
                            label.toLowerCase() == 'income' ||
                            label.toLowerCase() == 'paid' ||
                            label.toLowerCase() == 'done')
                        ? Colors.green.shade600
                        : (label.toLowerCase() == 'rejected' ||
                                label.toLowerCase() == 'expense')
                            ? Colors.red.shade800
                            : tp.isDarkMode
                                ? Colors.blueGrey.shade50
                                : Colors.blueGrey.shade900,
        fontSize: size,
      ),
    );
  }
}
