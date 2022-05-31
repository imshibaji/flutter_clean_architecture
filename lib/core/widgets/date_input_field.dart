import 'package:flutter/material.dart';

import '../core.dart';

// ignore: must_be_immutable
class DateInputField extends StatefulWidget {
  void Function(DateTime date) onDateChange;
  DateInputField({
    Key? key,
    required this.onDateChange,
  }) : super(key: key);

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime selectedDate = DateTime.now();
  TextEditingController? dateController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(
        text: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');
  }

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      keyboardType: TextInputType.none,
      controller: dateController,
      prefixIcon: Icons.watch_later_outlined,
      onTap: () async {
        final datePicked = await selectDate(context);
        if (datePicked.toString() != selectedDate.toString()) {
          setState(() {
            selectedDate = datePicked;
            dateController!.text =
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
            FocusScope.of(context).requestFocus(FocusNode());
            widget.onDateChange(selectedDate);
          });
        }
      },
      readOnly: true,
    );
  }
}
