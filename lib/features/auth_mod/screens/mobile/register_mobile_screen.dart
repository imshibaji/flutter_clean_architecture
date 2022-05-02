import 'package:clean_archetructure/core/helpers/actions_helper.dart';
import 'package:flutter/material.dart';

class RegisterMobileScreen extends StatelessWidget {
  const RegisterMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
        actions: actionsMenu(context),
      ),
    );
  }
}
