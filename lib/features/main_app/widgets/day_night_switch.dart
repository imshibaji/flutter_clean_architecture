import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme.dart';

class DayNightSwitch extends StatefulWidget {
  const DayNightSwitch({Key? key}) : super(key: key);

  @override
  _DayNightSwitchState createState() => _DayNightSwitchState();
}

class _DayNightSwitchState extends State<DayNightSwitch> {
  bool dayAndNight = false;

  @override
  void initState() {
    super.initState();
    var tm = context.read<ThemeProvider>();
    dayAndNight = tm.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    var tm = context.read<ThemeProvider>();
    return Switch(
        value: dayAndNight,
        onChanged: (val) {
          setState(() {
            dayAndNight = val;
            tm.setThemeMode(dayAndNight);
          });
        });
  }
}
