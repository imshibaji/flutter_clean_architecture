import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/widget_functions.dart';

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({
    Key? key,
    void Function(String username, String password)? onLogged,
  }) : super(key: key);

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isPasswordHide = true;
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        actions: const [DayNightSwitch()],
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5.5,
              ),

              const Text(
                'Login Area',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),

              // Username Fields
              usernameField(
                onValid: (user) => username = user,
              ),
              const SizedBox(
                height: 10,
              ),

              // Password Fields
              passwordField(
                onValid: (pass) => password = pass,
                passHide: _isPasswordHide,
                onKeyBtnPressed: (val) {
                  setState(() {
                    _isPasswordHide = val;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),

              // Buttons Fields
              forgetButton(
                context,
                onForget: () {
                  return true;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              loginRegisterButtons(
                context,
                key: _globalKey,
                onLogin: () {
                  log('username: $username, password: $password');
                  doAuth(context, username!, password!);
                  return true;
                },
                onRegister: () {
                  return true;
                },
              ),
              const Divider(
                thickness: 3,
              ),

              // Social Login Buttons
              AuthButton(
                label: 'Login by Facebook',
                onPressed: () {},
                backgroundColor: const Color.fromARGB(255, 7, 108, 191),
                textColor: Colors.white,
                paddingValue: 15,
              ),
              AuthButton(
                label: 'Login by Google',
                onPressed: () {},
                backgroundColor: const Color.fromARGB(255, 235, 53, 17),
                textColor: Colors.white,
                paddingValue: 15,
              ),
              AuthButton(
                label: 'Login by LinkedIn',
                onPressed: () {},
                backgroundColor: const Color.fromARGB(255, 17, 126, 235),
                textColor: Colors.white,
                paddingValue: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
