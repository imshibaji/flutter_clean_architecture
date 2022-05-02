import 'package:clean_archetructure/core/helpers/actions_helper.dart';
import 'package:flutter/material.dart';

class ForgetMobileScreen extends StatelessWidget {
  const ForgetMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Screen'),
        actions: actionsMenu(context),
      ),
    );
  }
}
