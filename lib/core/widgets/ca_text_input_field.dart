import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CATextInputField extends StatelessWidget {
  IconData? prefixIcon = Icons.ac_unit;
  String? labelTextStr;
  String? hintTextStr;
  String? initialValue;
  bool obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  TextEditingController? controller;
  Function(String? value)? validator, onSaved;
  Widget? suffixIcon;

  CATextInputField({
    Key? key,
    this.prefixIcon,
    this.labelTextStr,
    this.hintTextStr,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.validator,
    this.onSaved,
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
        onSaved: (value) => onSaved!(value),
        initialValue: initialValue,
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
