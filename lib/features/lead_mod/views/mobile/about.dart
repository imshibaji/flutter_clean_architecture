import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../lead_mod.dart';

class AboutForMobile extends StatelessWidget {
  const AboutForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
