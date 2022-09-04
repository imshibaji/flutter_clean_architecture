import 'package:clean_architecture/features/lead_mod/lead_mod.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AddEnqueryForMobile extends StatefulWidget {
  const AddEnqueryForMobile({Key? key}) : super(key: key);

  @override
  State<AddEnqueryForMobile> createState() => _AddEnqueryForMobileState();
}

class _AddEnqueryForMobileState extends State<AddEnqueryForMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String? purpose, name, email, mobile, source, status;

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
        key: _formState,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            CATextInputField(
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
            CATextInputField(
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
            CATextInputField(
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
            CATextInputField(
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
            CATextInputField(
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
                'new',
                'pending',
                'processing',
                'success',
                'rejected',
                'expired',
              ],
              selected: 'new',
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
                  onPressed: () async {
                    if (_formState.currentState!.validate()) {
                      EnqueryService es = EnqueryService();
                      var res = await es.create(Lead(
                        purpose: purpose,
                        customer_name: name,
                        customer_email: email,
                        customer_mobile: mobile,
                        source: source,
                        status: status,
                      ));
                      setState(() {});
                      if (res != null) {
                        Nav.to(context, LeadApp.home);
                        showMessage(context, 'New Lead Data Saved');
                      }
                    }
                  },
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
