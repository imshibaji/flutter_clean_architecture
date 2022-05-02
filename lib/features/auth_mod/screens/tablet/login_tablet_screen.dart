import 'package:flutter/material.dart';

class LoginTabletScreen extends StatefulWidget {
  const LoginTabletScreen({Key? key}) : super(key: key);

  @override
  State<LoginTabletScreen> createState() => _LoginTabletScreenState();
}

class _LoginTabletScreenState extends State<LoginTabletScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isPasswordHide = true;

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
            Padding(
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
                  return null;
                },
              ),
            ),

            // Password Fields
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: _isPasswordHide,
                decoration: InputDecoration(
                  hintText: 'password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordHide = !_isPasswordHide;
                        });
                      },
                      icon: Icon(_isPasswordHide ? Icons.key : Icons.key_off)),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please Input password';
                  }
                  return null;
                },
              ),
            ),

            // Buttons Fields
            Padding(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        debugPrint('Login Validate');
                      }
                    },
                    child: const Text('Login Now'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        debugPrint('Register now');
                      }
                    },
                    child: const Text('Register Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
