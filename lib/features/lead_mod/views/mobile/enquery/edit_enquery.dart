import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../lead_mod.dart';

class EditEnqueryForMobile extends StatefulWidget {
  const EditEnqueryForMobile({Key? key}) : super(key: key);

  @override
  State<EditEnqueryForMobile> createState() => _EditEnqueryForMobileState();
}

class _EditEnqueryForMobileState extends State<EditEnqueryForMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String? purpose, name, email, mobile, source, status;
  Lead? lead;

  @override
  Widget build(BuildContext context) {
    EnqueryData ed = (ModalRoute.of(context)!.settings.arguments == null)
        ? EnqueryData()
        : ModalRoute.of(context)!.settings.arguments! as EnqueryData;
    setState(() {
      lead = ed.attributes!;
    });
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
        key: _formState,
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Purpose',
              initialValue: lead!.purpose ?? '',
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
              initialValue: lead!.customer_name ?? '',
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
              initialValue: lead!.customer_email ?? '',
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
              initialValue: lead!.customer_mobile ?? '',
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
              initialValue: lead!.source ?? '',
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
              selected: lead!.status ?? 'pending',
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
                      var res = await es.update(
                          ed.id!.toInt(),
                          Lead(
                            purpose: purpose,
                            customer_name: name,
                            customer_email: email,
                            customer_mobile: mobile,
                            source: source,
                            status: status,
                          ));

                      if (res != null) {
                        var ep = context.read<EnqueryProvider>();
                        ep.findEnqeryData(ed.id!);

                        Nav.to(context, LeadApp.viewEnquery, arguments: ed);
                        showMessage(context, 'Existing Lead Data Saved');
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
