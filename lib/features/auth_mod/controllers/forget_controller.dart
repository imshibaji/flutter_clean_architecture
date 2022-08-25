import 'package:flutter/material.dart';

import '../screens/mobile/forget_mobile_screen.dart';

class ForgetController extends StatelessWidget {
  const ForgetController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Forget Section',
      color: Colors.blue,
      child: const ForgetMobileScreen(),
    );
  }
}
