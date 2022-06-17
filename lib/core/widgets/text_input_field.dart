import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputField extends StatelessWidget {
  IconData? prefixIcon = Icons.ac_unit;
  String? labelTextStr;
  String? hintTextStr;
  String? initialValue;
  bool obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  TextEditingController? controller;
  String? Function(String? value)? validator;
  void Function(String? value)? onSaved, onChanged, onFieldSubmitted;
  void Function()? onEditingComplete, onTap;
  Widget? suffixIcon;
  bool autocorrect, readOnly, autofocus, isBorder;
  Iterable<String>? autofillHints;
  int? maxLength, minLines, maxLines;
  EdgeInsetsGeometry? contentPadding;
  TextDirection? textDirection;
  TextAlign textAlign;
  TextAlignVertical? textAlignVertical;

  TextInputField({
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
    this.onEditingComplete,
    this.autocorrect = true,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.autofillHints,
    this.readOnly = false,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.autofocus = false,
    this.contentPadding = EdgeInsets.zero,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.isBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        onSaved: onSaved,
        initialValue: initialValue,
        onEditingComplete: onEditingComplete,
        autocorrect: autocorrect,
        onTap: onTap,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        autofillHints: autofillHints,
        readOnly: readOnly,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        key: key,
        autofocus: autofocus,
        textDirection: textDirection,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          labelText: labelTextStr,
          labelStyle: const TextStyle(fontSize: 20),
          hintText: hintTextStr,
          contentPadding: contentPadding,
          border: isBorder
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(9),
                  ),
                  gapPadding: 0.0,
                )
              : null,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
