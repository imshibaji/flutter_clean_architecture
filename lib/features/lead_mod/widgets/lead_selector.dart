import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../dbobj/dbobjs.dart';

// ignore: must_be_immutable
class LeadSelectOptionField extends StatefulWidget {
  List<Lead>? options;
  Lead? selected;
  IconData? prefixIcon;
  String? labelTextStr, hintTextStr, errorTextStr;
  Widget? suffixIcon;
  Function(Lead?) validator;
  Function(Lead?)? onSaved;
  Function(Lead?)? onChanged;
  bool? isBorder;

  LeadSelectOptionField({
    Key? key,
    this.options = const [],
    this.selected,
    this.prefixIcon,
    this.labelTextStr,
    this.hintTextStr,
    this.errorTextStr,
    this.suffixIcon,
    required this.validator,
    this.onSaved,
    this.isBorder = true,
    this.onChanged,
  }) : super(key: key);

  @override
  State<LeadSelectOptionField> createState() => _SelectOptionFieldState();
}

class _SelectOptionFieldState extends State<LeadSelectOptionField> {
  String? errorTxt;

  @override
  Widget build(BuildContext context) {
    ThemeProvider tp = context.watch<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
      child: DropdownButtonFormField<Lead>(
        validator: (value) => widget.validator(value),
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
        items: widget.options!
            .map(
              (Lead option) => DropdownMenuItem<Lead>(
                value: option,
                child: Text(option.name ?? ''),
              ),
            )
            .toList(),
        onChanged: (value) {
          widget.selected = value!;
          widget.onChanged!(value);
        },
        hint: const Text('Choose'),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
