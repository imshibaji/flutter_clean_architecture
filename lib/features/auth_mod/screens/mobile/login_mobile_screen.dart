import 'dart:developer';

import 'package:clean_archetructure/core/helpers/login_helper.dart';
import 'package:clean_archetructure/core/widgets/day_night_switch.dart';
import 'package:clean_archetructure/features/auth_mod/widgets/text_input_field.dart';
import 'package:clean_archetructure/features/auth_mod/widgets/widget_functions.dart';
import 'package:flutter/material.dart';

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
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.8,
            ),

            const Center(
              child: Text(
                'Login Area',
                style: TextStyle(fontSize: 30),
              ),
            ),

            // Username Fields
            TextInputField(
              prefixIcon: Icons.account_circle_outlined,
              labelTextStr: 'Input Username',
              validator: (user) {
                if (user != null) {
                  username = user;
                  return null;
                }
                return 'Please Input your Username';
              },
            ),
            // usernameField(
            //   onValid: (user) => username = user,
            // ),

            // Password Fields
            TextInputField(
              prefixIcon: Icons.security_outlined,
              labelTextStr: 'Input Password',
              validator: (pass) {
                if (pass != null) {
                  password = pass;
                  return null;
                }
                return 'Please Input Your Password';
              },
              obscureText: _isPasswordHide,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordHide = !_isPasswordHide;
                  });
                },
                icon: Icon(
                  _isPasswordHide
                      ? Icons.visibility
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            // passwordField(
            //   onValid: (pass) => password = pass,
            //   passHide: _isPasswordHide,
            //   onKeyBtnPressed: (val) {
            //     setState(() {
            //       _isPasswordHide = val;
            //     });
            //   },
            // ),

            // Buttons Fields
            forgetButton(
              context,
              onForget: () {
                return true;
              },
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 220, 70, 0),
                ),
                onPressed: () {},
                child: const Text(
                  'Login by Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 60, 181),
                ),
                onPressed: () {},
                child: const Text(
                  'Login by Facebook',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 1, 158, 255),
                ),
                onPressed: () {},
                child: const Text(
                  'Login by LinkedIn',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
