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
      body: Form(
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Purpose',
            ),
            TextInputField(
              prefixIcon: Icons.face,
              labelTextStr: 'Customer Name',
            ),
            TextInputField(
              prefixIcon: Icons.email,
              labelTextStr: 'Customer Email',
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Customer Phone Number',
            ),
            TextInputField(
              prefixIcon: Icons.source_outlined,
              labelTextStr: 'Source of Contact',
            ),
            SelectOptionField(
              prefixIcon: Icons.water_drop_outlined,
              labelTextStr: 'Status',
              options: const [
                'new',
                'pending',
                'success',
                'rejected',
                'expaired',
              ],
              selected: 'new',
            ),
            AppButton(
              label: 'Save Now',
              onPressed: () {},
              stretch: true,
            ),
          ],
        ),
      ),
    );
  }
}
