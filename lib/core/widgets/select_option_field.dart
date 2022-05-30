import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';

// ignore: must_be_immutable
class SelectOptionField extends StatefulWidget {
  List<String>? options;
  String? selected;
  IconData? prefixIcon;
  String? labelTextStr, hintTextStr;
  Widget? suffixIcon;
  Function(String?)? validator, onSaved;

  SelectOptionField({
    Key? key,
    this.options,
    this.selected,
    this.prefixIcon,
    this.labelTextStr,
    this.hintTextStr,
    this.suffixIcon,
    this.validator,
    this.onSaved,
  }) : super(key: key) {
    options = options ?? ['One', 'Two', 'Three', 'Four'];
    selected = selected ?? 'One';
  }

  @override
  State<SelectOptionField> createState() => _SelectOptionFieldState();
}

class _SelectOptionFieldState extends State<SelectOptionField> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider tp = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
      child: DropdownButtonFormField<String>(
        validator: (value) => widget.validator!(value),
        onSaved: (value) => widget.onSaved!(value),
        dropdownColor: tp.isDarkMode
            ? const Color.fromARGB(255, 32, 36, 36)
            : const Color.fromARGB(255, 127, 236, 242),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          labelText: widget.labelTextStr,
          contentPadding: EdgeInsets.zero,
          labelStyle: const TextStyle(fontSize: 20),
          hintText: widget.hintTextStr,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          suffixIcon: widget.suffixIcon,
        ),
        value: widget.selected,
        items: widget.options!
            .map(
              (String option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ),
            )
            .toList(),
        onChanged: (value) {
          widget.selected = value!;
        },
      ),
    );
  }
}
