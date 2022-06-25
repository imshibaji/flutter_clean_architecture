import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';

// ignore: must_be_immutable
class SelectOptionField extends StatefulWidget {
  List<String> options;
  String? selected;
  IconData? prefixIcon;
  String? labelTextStr, hintTextStr, errorTextStr;
  Widget? suffixIcon;
  Function(String?)? validator, onSaved, onChanged;
  bool? isBorder;

  SelectOptionField({
    Key? key,
    required this.options,
    this.selected,
    this.prefixIcon,
    this.labelTextStr,
    this.hintTextStr,
    this.errorTextStr,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.isBorder = true,
  }) : super(key: key);

  @override
  State<SelectOptionField> createState() => _SelectOptionFieldState();
}

class _SelectOptionFieldState extends State<SelectOptionField> {
  String? errorTxt;

  @override
  Widget build(BuildContext context) {
    ThemeProvider tp = context.watch<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
      child: DropdownButtonFormField<String>(
        validator: (value) => widget.errorTextStr = widget.validator!(value),
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
          errorText: widget.errorTextStr,
          border: widget.isBorder!
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(9),
                  ),
                )
              : null,
          suffixIcon: widget.suffixIcon,
        ),
        value: widget.selected,
        items: widget.options.isNotEmpty
            ? widget.options
                .map(
                  (String option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList()
            : [
                const DropdownMenuItem<String>(
                  value: 'None',
                  child: Text('None'),
                ),
              ],
        onChanged: (value) {
          widget.selected = value!;
          widget.onChanged != null ? widget.onChanged!(value) : null;
        },
        hint: const Text('Choose'),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
