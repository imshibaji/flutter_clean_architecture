import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

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

class _AddLeadForMobileState extends State<AddLeadForMobile>
    with AfterLayoutMixin {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController? name, email, mobile, address;
  Lead lead = Lead();
  Contact? _contact;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final contact = Nav.routeData(context) as Contact?;
    if (contact != null) {
      setState(() {
        _contact = contact;
      });
      // printPrettyJson(contact!);
      _fetchContact();
    }
  }

  Future _fetchContact() async {
    // First fetch all contact details
    await _fetchContactWith(highRes: false);

    // Then fetch contact with high resolution photo
    await _fetchContactWith(highRes: true);
  }

  Future _fetchContactWith({required bool highRes}) async {
    final contact = await FlutterContacts.getContact(
      _contact!.id,
      withThumbnail: !highRes,
      withPhoto: highRes,
      withGroups: true,
      withAccounts: true,
    );
    setState(() {
      _contact = contact;

      if (_contact!.displayName.isNotEmpty) {
        name = TextEditingController(text: _contact!.displayName);
      }
      if (_contact!.phones.isNotEmpty) {
        mobile = TextEditingController(text: _contact!.phones.first.number);
      }
      if (_contact!.emails.isNotEmpty) {
        email = TextEditingController(text: _contact!.emails.first.address);
      }

      if (_contact!.addresses.isNotEmpty) {
        String addr = '';
        if (_contact!.addresses.first.address.isNotEmpty) {
          addr = _contact!.addresses.first.address;
        }
        final adds = addr;
        log(adds);
        address = TextEditingController(text: adds);
      }
    });
  }

  addContactFromPhone() {
    if (Platform.isAndroid || Platform.isIOS) {
      return InkWell(
        onTap: () {
          Nav.to(context, LeadApp.contactList);
        },
        child: const Icon(
          Icons.contact_page,
          semanticLabel: 'Add Contact From ContactList',
        ),
      );
    }
    return null;
  }

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
              prefixIcon: Icons.face,
              labelTextStr: 'Name',
              suffixIcon: addContactFromPhone(),
              controller: name,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.name = val;
                  // setState(() {});
                  return null;
                }
                return 'Input Customer Name';
              },
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Purpose',
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.purpose = val;
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.email,
              labelTextStr: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: email,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.email = val;
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.phone,
              labelTextStr: 'Phone Number',
              keyboardType: TextInputType.phone,
              controller: mobile,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.mobile = val;
                  // setState(() {});
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
                  // setState(() {});
                  return null;
                }
                return null;
              },
            ),
            TextInputField(
              prefixIcon: Icons.maps_home_work_outlined,
              labelTextStr: 'Address',
              keyboardType: TextInputType.streetAddress,
              controller: address,
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.address = val;
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
              selected: 'Others',
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.source = val;
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
              selected: 'New',
              validator: (val) {
                if (val!.isNotEmpty) {
                  lead.status = val;
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
