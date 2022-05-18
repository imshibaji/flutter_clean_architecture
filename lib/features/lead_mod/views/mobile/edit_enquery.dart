import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../lead_app.dart';
import '../../models/enquery_get_models.dart';
import '../../widgets/button_bar.dart';

class EditEnqueryForMobile extends StatelessWidget {
  const EditEnqueryForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lead lead = (ModalRoute.of(context)!.settings.arguments == null)
        ? Lead()
        : ModalRoute.of(context)!.settings.arguments! as Lead;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.home);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Edit Lead'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      body: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Purpose',
              initialValue: lead.purpose ?? '',
            ),
            TextInputField(
              prefixIcon: Icons.face,
              labelTextStr: 'Customer Name',
              initialValue: lead.customer_name ?? '',
            ),
            TextInputField(
              prefixIcon: Icons.email,
              labelTextStr: 'Customer Email',
              initialValue: lead.customer_email ?? '',
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Customer Phone Number',
              initialValue: lead.customer_mobile ?? '',
            ),
            TextInputField(
              prefixIcon: Icons.source_outlined,
              labelTextStr: 'Source of Contact',
              initialValue: lead.source ?? '',
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
              selected: lead.status ?? 'new',
            ),
            Row(
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: () {},
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
