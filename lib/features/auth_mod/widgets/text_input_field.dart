import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputField extends StatelessWidget {
  IconData? prefixIcon = Icons.ac_unit;
  String? labelTextStr;
  String? hintTextStr;
  bool obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  TextEditingController? controller;
  Function(String? value)? validator;
  Widget? suffixIcon;

  TextInputField({
    Key? key,
    this.prefixIcon,
    this.labelTextStr,
    this.hintTextStr,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextFormField(
        validator: (value) => validator!(value),
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          labelText: labelTextStr,
          labelStyle: const TextStyle(fontSize: 20),
          hintText: hintTextStr,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
