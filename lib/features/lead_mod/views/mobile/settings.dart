import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../dbobj/dbobjs.dart';
import '../../services/services.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ProfileService? ps;
  Profile? profile;

  String? imgPath;
  bool seePass = true;

  @override
  void initState() {
    super.initState();
    ps = ProfileService();
    if (ps!.box!.isNotEmpty) {
      if (profile == null) {
        setState(() {
          profile = ps!.get(0);
          // log(business.toString());
        });
      }
    } else {
      profile = Profile();
      ps!.add(profile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        actions: actionsMenu(context),
      ),
      body: Column(children: [
        const Divider(),
        const Center(child: Text('App Settings')),
        TextInputField(
          labelTextStr: 'Passcode',
          prefixIcon: Icons.security,
          initialValue: profile!.password ?? '',
          obscureText: seePass,
          maxLength: 6,
          keyboardType: TextInputType.number,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                seePass = !seePass;
              });
            },
            icon: Icon(
              seePass == true ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          validator: (val) {
            if (val!.isNotEmpty) {
              profile!.password = val;
              // return null;
            }
            return null;
          },
        ),
        Row(
          children: [
            Switch(value: true, onChanged: (val) {}),
            const Text('Enable / Disable Login Screen')
          ],
        ),
        Row(
          children: const [
            DayNightSwitch(),
            Text('Day / Night Mode'),
          ],
        ),
      ]),
    );
  }
}
