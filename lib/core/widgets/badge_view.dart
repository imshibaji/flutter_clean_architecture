import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Badge extends StatelessWidget {
  Color? color;
  String label;

  Badge({
    Key? key,
    this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 3,
      // padding: const EdgeInsets.all(0),
      labelPadding: const EdgeInsets.all(4),

      backgroundColor: color ?? Colors.blue,
      label: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}
