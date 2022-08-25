import 'package:flutter/material.dart';

import '../screens/mobile/profile_mobile.screen.dart';

class ProfileController extends StatelessWidget {
  const ProfileController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Profile Section',
      color: Colors.blue,
      child: const ProfileMobileScreen(),
    );
  }
}
