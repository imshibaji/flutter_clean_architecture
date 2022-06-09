import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class HelpMobileView extends StatelessWidget {
  const HelpMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helps'),
        actions: actionsMenu(context),
      ),
      body: const Center(
        child: Text('Tutorials is not Avaliable'),
      ),
    );
  }
}
