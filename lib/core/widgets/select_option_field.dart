import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: DropdownButtonFormField<String>(
        validator: (value) => widget.validator!(value),
        onSaved: (value) => widget.onSaved!(value),
        dropdownColor: const Color.fromARGB(255, 11, 238, 250),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          labelText: widget.labelTextStr,
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
