import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../dbobj/lead.dart';
import '../../../lead_app.dart';
import '../../../providers/providers.dart';
import '../../../widgets/widgets.dart';

class AddLeadForMobile extends StatefulWidget {
  const AddLeadForMobile({Key? key}) : super(key: key);

  @override
  State<AddLeadForMobile> createState() => _AddLeadForMobileState();
}

class _AddLeadForMobileState extends State<AddLeadForMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String? purpose, name, email, mobile, source, status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.listLeads);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Add New Lead'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      body: Form(
        key: _formState,
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Purpose',
              validator: (val) {
                if (val!.isNotEmpty) {
                  purpose = val;
                  setState(() {});
                  return null;
                }
                return 'Input Purpose';
              },
            ),
            TextInputField(
              prefixIcon: Icons.face,
              labelTextStr: 'Customer Name',
              validator: (val) {
                if (val!.isNotEmpty) {
                  name = val;
                  setState(() {});
                  return null;
                }
                return 'Input Customer Name';
              },
            ),
            TextInputField(
              prefixIcon: Icons.email,
              labelTextStr: 'Customer Email',
              validator: (val) {
                if (val!.isNotEmpty) {
                  email = val;
                  setState(() {});
                  return null;
                }
                return 'Input Customer Email';
              },
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Customer Phone Number',
              validator: (val) {
                if (val!.isNotEmpty) {
                  mobile = val;
                  setState(() {});
                  return null;
                }
                return 'Input Customer Mobile Number';
              },
            ),
            TextInputField(
              prefixIcon: Icons.source_outlined,
              labelTextStr: 'Source of Contact',
              validator: (val) {
                if (val!.isNotEmpty) {
                  source = val;
                  setState(() {});
                  return null;
                }
                return 'Input Source of Contact';
              },
            ),
            SelectOptionField(
              prefixIcon: Icons.water_drop_outlined,
              labelTextStr: 'Status',
              options: const [
                'New',
                'Pending',
                'Interested',
                'Success',
                'Rejected',
                'Expired',
              ],
              selected: 'New',
              validator: (val) {
                if (val!.isNotEmpty) {
                  status = val;
                  setState(() {});
                  return null;
                }
                return 'Input Status';
              },
            ),
            Row(
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: onSubmit,
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onSubmit() async {
    if (_formState.currentState!.validate()) {
      // Leads Added Offline
      Lead lead = Lead();
      lead.uid = uuid();
      lead.purpose = purpose;
      lead.name = name;
      lead.email = email;
      lead.mobile = mobile;
      lead.source = source;
      lead.status = status;

      ServiceProvider sp = context.read<ServiceProvider>();
      sp.addLead(lead);

      setState(() {});
      Nav.to(context, LeadApp.listLeads);
      showMessage(context, 'New Lead Data Saved');
    }
  }
}
