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
  // String? purpose, name, email, mobile, source, status;
  Lead? lead;
  Lead ilead = Lead();

  @override
  Widget build(BuildContext context) {
    lead = (ModalRoute.of(context)!.settings.arguments == null)
        ? Lead()
        : ModalRoute.of(context)!.settings.arguments! as Lead;

    setState(() {
      ilead = lead!;
    });
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
              prefixIcon: Icons.face,
              labelTextStr: 'Name',
              initialValue: lead!.name ?? '',
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.name = val;
                  // setState(() {});
                  return null;
                }
                return 'Input Customer Name';
              },
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Purpose',
              initialValue: lead!.purpose ?? '',
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.purpose = val;
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.email,
              labelTextStr: 'Email',
              initialValue: lead!.email ?? '',
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.email = val;
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Phone Number',
              initialValue: lead!.mobile ?? '',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.mobile = val;
                  // setState(() {});
                  return null;
                }
                return 'Input Customer Mobile Number';
              },
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Alternate Phone Number',
              initialValue: lead!.altMobile ?? '',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.altMobile = val;
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.maps_home_work_outlined,
              labelTextStr: 'Address',
              initialValue: lead!.address ?? '',
              keyboardType: TextInputType.streetAddress,
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.address = val;
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            SelectOptionField(
              prefixIcon: Icons.source_outlined,
              labelTextStr: 'Source',
              options: leadSources,
              selected: lead!.source ?? 'Others',
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.source = val;
                  // setState(() {});
                  return null;
                }
                return 'Input Source of Contact';
              },
            ),
            SelectOptionField(
              prefixIcon: Icons.water_drop_outlined,
              labelTextStr: 'Status',
              options: leadStatuses,
              selected: lead!.status ?? 'Pending',
              validator: (val) {
                if (val!.isNotEmpty) {
                  ilead.status = val;
                  // setState(() {});
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

  onSubmit() async {
    if (_formState.currentState!.validate()) {
      // Leads Update Offline
      await ilead.save();

      ServiceProvider sp = context.read<ServiceProvider>();
      // await sp.updateLead(ilead);
      sp.getAllLeads();

      setState(() {});

      Nav.to(context, LeadApp.viewLead, arguments: lead);
      showMessage(context, 'Existing Lead Data Saved');
    }
  }
}
