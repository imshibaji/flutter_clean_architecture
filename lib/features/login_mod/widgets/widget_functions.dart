import 'package:flutter/material.dart';

Padding passwordField({
  String? Function(String?)? onValid,
  bool passHide = true,
  void Function(bool)? onKeyBtnPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      obscureText: passHide,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
            onPressed: () {
              passHide = !passHide;
              onKeyBtnPressed!(passHide);
            },
            icon: Icon(passHide ? Icons.key : Icons.key_off)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please Input password';
        }
        onValid!(val);
        return null;
      },
    ),
  );
}

Padding usernameField({String? Function(String?)? onValid}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      decoration: const InputDecoration(
        hintText: 'Username',
        prefixIcon: Icon(Icons.face),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please Input username';
        }
        onValid!(val);
        return null;
      },
    ),
  );
}

Padding loginRegisterButtons({
  GlobalKey<FormState>? key,
  void Function()? onLogin,
  void Function()? onRegister,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            if (key!.currentState!.validate()) {
              debugPrint('Login Validate');
              onLogin!();
            }
          },
          child: const Text('Login Now'),
        ),
        ElevatedButton(
          onPressed: () {
            if (key!.currentState!.validate()) {
              debugPrint('Register now');
              onRegister!();
            }
          },
          child: const Text('Register Now'),
        ),
      ],
    ),
  );
}

Padding forgetButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            debugPrint('Forget Password Click');
          },
          child: const Text(
            'Forget Password',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    ),
  );
}
