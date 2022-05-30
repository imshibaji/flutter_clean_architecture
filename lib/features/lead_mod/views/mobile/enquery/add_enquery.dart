import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
// import '../../../dbobj/lead.dart' as ol;
import '../../../lead_mod.dart';

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
      // Leads Added Online
      EnqueryService es = EnqueryService();
      var res = await es.create(Lead(
        purpose: purpose,
        customer_name: name,
        customer_email: email,
        customer_mobile: mobile,
        source: source,
        status: status,
      ));

      // Leads Added Offline
      // LeadService ls = LeadService();
      // ls.add(
      //   ol.Lead(
      //     uid: uuid(),
      //     purpose: purpose,
      //     name: name,
      //     email: email,
      //     mobile: mobile,
      //     source: source,
      //     status: status,
      //   ),
      // );

      setState(() {});
      if (res != null) {
        Nav.to(context, LeadApp.listEnquery);
        showMessage(context, 'New Lead Data Saved');
      }
    }
  }
}
