import 'dart:developer';

import 'package:clean_architecture/features/lead_mod/dbobj/business.dart';
import 'package:clean_architecture/features/lead_mod/services/services.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class BusinessMobileView extends StatefulWidget {
  const BusinessMobileView({Key? key}) : super(key: key);

  @override
  State<BusinessMobileView> createState() => _BusinessMobileViewState();
}

class _BusinessMobileViewState extends State<BusinessMobileView> {
  final GlobalKey<FormState> _form = GlobalKey();
  BusinessService? bs;
  Business? business;

  @override
  void initState() {
    super.initState();
    bs = BusinessService();
    if (bs!.box!.isNotEmpty) {
      if (business == null) {
        setState(() {
          business = bs!.get(0);
          // log(business.toString());
        });
      }
    } else {
      business = Business();
      bs!.add(business!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business'),
        actions: actionsMenu(context),
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextInputField(
                labelTextStr: 'Business Name',
                prefixIcon: Icons.business,
                initialValue: business!.name,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.name = val;
                    return null;
                  }
                  return 'Please Input Business Name';
                },
              ),
              TextInputField(
                labelTextStr: 'Business Address',
                prefixIcon: Icons.maps_ugc_outlined,
                initialValue: business!.address,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.address = val;
                  }
                  return null;
                },
              ),
              TextInputField(
                labelTextStr: 'City / Village',
                prefixIcon: Icons.location_city_rounded,
                initialValue: business!.city,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.city = val;
                    return null;
                  }
                  return 'Please Input City/Village';
                },
              ),
              TextInputField(
                labelTextStr: 'State / Region',
                prefixIcon: Icons.location_city_rounded,
                initialValue: business!.state,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.state = val;
                  }
                  return null;
                },
              ),
              TextInputField(
                labelTextStr: 'Country',
                prefixIcon: Icons.map,
                initialValue: business!.country,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.country = val;
                    return null;
                  }
                  return 'Please Input Country';
                },
              ),
              TextInputField(
                labelTextStr: 'Pincode',
                prefixIcon: Icons.map,
                keyboardType: TextInputType.number,
                initialValue: (business!.pincode != null)
                    ? business!.pincode.toString()
                    : '',
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.pincode = int.parse(val);
                    return null;
                  }
                  return 'Please Input Pincode Number';
                },
              ),
              TextInputField(
                labelTextStr: 'Official Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                initialValue: business!.email,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.email = val;
                  }
                  return null;
                },
              ),
              TextInputField(
                labelTextStr: 'Official Website',
                prefixIcon: Icons.web,
                initialValue: business!.website,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.website = val;
                  }
                  return null;
                },
              ),
              TextInputField(
                labelTextStr: 'Official Phone Number',
                prefixIcon: Icons.location_city_rounded,
                keyboardType: TextInputType.phone,
                initialValue: business!.phone,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.phone = val;
                    return null;
                  }
                  return 'Please Input Phone Number';
                },
              ),
              TextInputField(
                labelTextStr: 'Alternate Phone Number',
                prefixIcon: Icons.location_city_rounded,
                keyboardType: TextInputType.phone,
                initialValue: business!.altPhone,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    business!.altPhone = val;
                  }
                  return null;
                },
              ),
              AppButton(label: 'Save Now', onPressed: onSubmit),
              ...copyright().toList(),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    if (_form.currentState!.validate()) {
      Business iBiz = business!;
      iBiz.uid = uuid();
      iBiz.save();

      final data = iBiz.toString();
      log(data);
      showMessage(context, 'Business Data saved successfully.');
    }
  }

  List<Widget> copyright() => [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Developed By: '),
            Text(
              'SDN Technology',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ];
}
