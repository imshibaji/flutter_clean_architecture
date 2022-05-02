import 'package:clean_archetructure/features/auth_mod/screens/mobile/forget_mobile_screen.dart';
import 'package:flutter/material.dart';

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
