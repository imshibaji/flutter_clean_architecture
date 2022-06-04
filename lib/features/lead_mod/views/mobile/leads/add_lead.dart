import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../dbobj/lead.dart';
import '../../../lead_app.dart';
import '../../../providers/providers.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class AddLeadForMobile extends StatefulWidget {
  const AddLeadForMobile({Key? key}) : super(key: key);

  @override
  State<AddLeadForMobile> createState() => _AddLeadForMobileState();
}

class _AddLeadForMobileState extends State<AddLeadForMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  // String? purpose, name, email, mobile, source, status;
  Lead lead = Lead();

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
                  lead.purpose = val;
                  setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.face,
              labelTextStr: 'Customer Name',
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.name = val;
                  setState(() {});
                  return null;
                }
                return 'Input Customer Name';
              },
            ),
            TextInputField(
              prefixIcon: Icons.email,
              labelTextStr: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.email = val;
                  setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Phone Number',
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.mobile = val;
                  setState(() {});
                  return null;
                }
                return 'Input Customer Mobile Number';
              },
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Alternate Phone Number',
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.altMobile = val;
                  setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.maps_home_work_outlined,
              labelTextStr: 'Address',
              keyboardType: TextInputType.streetAddress,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.address = val;
                  setState(() {});
                  return null;
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SelectOptionField(
                    prefixIcon: Icons.source_outlined,
                    labelTextStr: 'Source',
                    options: leadSources,
                    selected: 'Others',
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        lead.source = val;
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
                    selected: 'New',
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        lead.status = val;
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

  void onSubmit() async {
    if (_formState.currentState!.validate()) {
      // Leads Added Offline
      lead.uid = uuid();
      ServiceProvider sp = context.read<ServiceProvider>();
      sp.addLead(lead);

      setState(() {});
      Nav.to(context, LeadApp.listLeads);
      showMessage(context, 'New Lead Data Saved');
    }
  }
}
