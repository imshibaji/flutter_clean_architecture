import 'package:clean_archetructure/features/auth_mod/screens/mobile/register_mobile_screen.dart';
import 'package:flutter/material.dart';

class RegisterController extends StatelessWidget {
  const RegisterController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Login Section',
      color: Colors.blue,
      child: const RegisterMobileScreen(),
    );
  }
}
