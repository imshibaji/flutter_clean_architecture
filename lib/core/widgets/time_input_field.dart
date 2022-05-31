import 'package:flutter/material.dart';

import '../core.dart';

// ignore: must_be_immutable
class TimeInputField extends StatefulWidget {
  void Function(TimeOfDay time) onTimeChange;
  TimeInputField({
    Key? key,
    required this.onTimeChange,
  }) : super(key: key);

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  TextEditingController? timeController;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    timeController = TextEditingController(
        text: '${selectedTime.hour}:${selectedTime.minute}');
  }

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      keyboardType: TextInputType.none,
      controller: timeController,
      prefixIcon: Icons.watch_later_outlined,
      onTap: () async {
        final timePicked = await selectTime(context);
        if (timePicked.toString() != selectedTime.toString()) {
          setState(() {
            selectedTime = timePicked;
            timeController!.text =
                '${selectedTime.hour}:${selectedTime.minute}';
            FocusScope.of(context).requestFocus(FocusNode());
            widget.onTimeChange(selectedTime);
          });
        }
      },
      readOnly: true,
    );
  }
}
