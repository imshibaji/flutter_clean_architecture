import 'package:flutter/material.dart';

import '../../widgets/widget_functions.dart';

class LoginDesktopScreen extends StatefulWidget {
  const LoginDesktopScreen({Key? key}) : super(key: key);

  @override
  State<LoginDesktopScreen> createState() => _LoginDesktopScreenState();
}

class _LoginDesktopScreenState extends State<LoginDesktopScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final bool _isPasswordHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.8,
            ),

            const Text(
              'Login Area',
              style: TextStyle(fontSize: 30),
            ),

            // Username Fields
            usernameField(),

            // Password Fields
            passwordField(passHide: _isPasswordHide),

            // Buttons Fields
            forgetButton(context),
            loginRegisterButtons(context, key: _globalKey),
          ],
        ),
      ),
    );
  }
}
