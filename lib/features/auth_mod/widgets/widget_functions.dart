import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'auth_button.dart';

TextInputField passwordField({
  String? Function(String?)? onValid,
  bool passHide = true,
  void Function(bool)? onKeyBtnPressed,
}) {
  return TextInputField(
    prefixIcon: Icons.security_outlined,
    labelTextStr: 'Input Password',
    validator: (val) {
      if (val == null || val.isEmpty) {
        return 'Please Input password';
      }
      onValid!(val);
      return null;
    },
    obscureText: passHide,
    suffixIcon: IconButton(
      onPressed: () {
        passHide = !passHide;
        onKeyBtnPressed!(passHide);
      },
      icon: Icon(
        passHide ? Icons.visibility : Icons.visibility_off_outlined,
      ),
    ),
  );
}

TextInputField usernameField({String? Function(String?)? onValid}) {
  return TextInputField(
    prefixIcon: Icons.account_circle_outlined,
    labelTextStr: 'Input Username',
    validator: (val) {
      if (val == null || val.isEmpty) {
        return 'Please Input username';
      }
      onValid!(val);
      return null;
    },
  );
}

Row loginRegisterButtons(
  BuildContext context, {
  GlobalKey<FormState>? key,
  bool Function()? onLogin,
  bool Function()? onRegister,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AuthButton(
        onPressed: () {
          if (key!.currentState!.validate()) {
            debugPrint('Login Validate');
            bool isLogin = onLogin!();
            if (isLogin && isLogin == true) {
              Nav.to(context, '/');
            }
          }
        },
        label: 'Login Now',
        stretch: true,
      ),
      AuthButton(
        onPressed: () {
          debugPrint('Register now');
          bool isRegister = onRegister!();
          if (isRegister && isRegister == true) {
            Nav.to(context, '/register');
          }
        },
        label: 'Register Now',
        stretch: true,
      ),
    ],
  );
}

LinkButton forgetButton(
  BuildContext context, {
  bool Function()? onForget,
}) {
  return LinkButton(
    onPressed: () {
      debugPrint('Forget Password Click');
      var check = onForget!();
      if (check && check == true) {
        Nav.to(context, '/forget');
      }
    },
    labelStr: 'Forget Password',
  );
}
