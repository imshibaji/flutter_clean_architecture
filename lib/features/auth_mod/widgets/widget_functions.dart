import 'package:clean_archetructure/core/classes/route_manager.dart';
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

Padding loginRegisterButtons(
  BuildContext context, {
  GlobalKey<FormState>? key,
  bool Function()? onLogin,
  bool Function()? onRegister,
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
              bool isLogin = onLogin!();
              if (isLogin && isLogin == true) {
                Nav.to(context, '/');
              }
            }
          },
          child: const Text('Login Now'),
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint('Register now');
            bool isRegister = onRegister!();
            if (isRegister && isRegister == true) {
              Nav.to(context, '/register');
            }
          },
          child: const Text('Register Now'),
        ),
      ],
    ),
  );
}

Padding forgetButton(
  BuildContext context, {
  bool Function()? onForget,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: GestureDetector(
      onTap: () {
        debugPrint('Forget Password Click');
        var check = onForget!();
        if (check && check == true) {
          Nav.to(context, '/forget');
        }
      },
      child: const Center(
        child: Text(
          'Forget Password',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ),
  );
}
