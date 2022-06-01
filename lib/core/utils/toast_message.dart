import 'package:flutter/material.dart';

void showMessage(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(massage),
  ));
}
