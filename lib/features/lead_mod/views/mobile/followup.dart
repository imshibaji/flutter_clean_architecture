import 'package:clean_architecture/features/lead_mod/lead_mod.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class FollowupForMobile extends StatelessWidget {
  const FollowupForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followup'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
