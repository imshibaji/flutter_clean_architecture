import 'package:flutter/material.dart';

import '../../../../core/classes/route_manager.dart';
import '../../../../core/widgets/day_night_switch.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_input_field.dart';

class RegisterMobileScreen extends StatelessWidget {
  const RegisterMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
        leading: IconButton(
          onPressed: () {
            Nav.to(context, '/login');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: const [DayNightSwitch()],
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "If you don't have your account. Then",
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Register Yourself",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              TextInputField(
                prefixIcon: Icons.account_circle_outlined,
                labelTextStr: 'Enter Your Name',
              ),
              TextInputField(
                prefixIcon: Icons.email_outlined,
                labelTextStr: 'Enter Your Email',
              ),
              TextInputField(
                prefixIcon: Icons.security,
                labelTextStr: 'Enter Your Password',
                obscureText: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_rounded),
                ),
              ),
              TextInputField(
                prefixIcon: Icons.security,
                labelTextStr: 'Enter Your Confirm Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              AuthButton(
                  label: 'Register Now',
                  onPressed: () {
                    Nav.to(context, '/profile');
                  }),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Register With',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              socialButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Padding socialButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AuthButton(
            label: 'Facebook',
            onPressed: () {},
            backgroundColor: const Color.fromARGB(255, 7, 108, 191),
            stretch: true,
            textColor: Colors.white,
          ),
          AuthButton(
            label: 'Google',
            onPressed: () {},
            backgroundColor: const Color.fromARGB(255, 235, 53, 17),
            stretch: true,
            textColor: Colors.white,
          ),
          AuthButton(
            label: 'LinkedIn',
            onPressed: () {},
            backgroundColor: const Color.fromARGB(255, 17, 126, 235),
            stretch: true,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
