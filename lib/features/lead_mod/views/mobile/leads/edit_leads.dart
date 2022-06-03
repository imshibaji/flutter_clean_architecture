import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../lead_app.dart';
import '../../../providers/service_provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class EditLeadForMobile extends StatefulWidget {
  const EditLeadForMobile({Key? key}) : super(key: key);

  @override
  State<EditLeadForMobile> createState() => _EditLeadForMobileState();
}

class _EditLeadForMobileState extends State<EditLeadForMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String? purpose, name, email, mobile, source, status;
  Lead? lead;

  @override
  Widget build(BuildContext context) {
    lead = (ModalRoute.of(context)!.settings.arguments == null)
        ? Lead()
        : ModalRoute.of(context)!.settings.arguments! as Lead;
    // setState(() {
    //   lead = ed.attributes!;
    // });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.viewLead, arguments: lead);
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
              initialValue: lead!.name ?? '',
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
              initialValue: lead!.email ?? '',
              keyboardType: TextInputType.emailAddress,
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
              initialValue: lead!.mobile ?? '',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val!.isNotEmpty) {
                  mobile = val;
                  setState(() {});
                  return null;
                }
                return 'Input Customer Mobile Number';
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SelectOptionField(
                    prefixIcon: Icons.source_outlined,
                    labelTextStr: 'Source of Contact',
                    options: leadSources,
                    selected: lead!.source ?? 'Others',
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        source = val;
                        setState(() {});
                        return null;
                      }
                      return 'Input Source of Contact';
                    },
                  ),
                ),
                Expanded(
                  child: SelectOptionField(
                    prefixIcon: Icons.water_drop_outlined,
                    labelTextStr: 'Status',
                    options: leadStatuses,
                    selected: lead!.status ?? 'Pending',
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        status = val;
                        setState(() {});
                        return null;
                      }
                      return 'Input Status';
                    },
                  ),
                ),
              ],
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

  onSubmit() async {
    if (_formState.currentState!.validate()) {
      // Leads Update Offline
      Lead ilead = Lead();
      ilead = lead!;
      ilead.purpose = purpose;
      ilead.name = name;
      ilead.email = email;
      ilead.mobile = mobile;
      ilead.source = source;
      ilead.status = status;

      ServiceProvider sp = context.read<ServiceProvider>();
      await sp.updateLead(ilead);

      setState(() {});

      Nav.to(context, LeadApp.viewLead, arguments: lead);
      showMessage(context, 'Existing Lead Data Saved');
    }
  }
}
