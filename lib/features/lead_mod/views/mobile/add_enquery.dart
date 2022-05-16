import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../lead_app.dart';
import '../../widgets/button_bar.dart';

class AddEnqueryForMobile extends StatelessWidget {
  const AddEnqueryForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.home);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Add New Lead'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
