import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../dbobj/dbobjs.dart';
import '../../services/services.dart';

class OwnerProfileMobileView extends StatefulWidget {
  const OwnerProfileMobileView({Key? key}) : super(key: key);

  @override
  State<OwnerProfileMobileView> createState() => _OwnerProfileMobileViewState();
}

class _OwnerProfileMobileViewState extends State<OwnerProfileMobileView> {
  final GlobalKey<FormState> _form = GlobalKey();
  ProfileService? ps;
  Profile? profile;

  String? imgPath;

  @override
  void initState() {
    super.initState();
    ps = ProfileService();
    if (ps!.box!.isNotEmpty) {
      if (profile == null) {
        setState(() {
          profile = ps!.get(0);
          // log(business.toString());
        });
      }
    } else {
      profile = Profile();
      ps!.add(profile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Profile'),
        actions: actionsMenu(context),
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    // Image Uploader Function
                  },
                  child: CircleAvatar(
                    child: (imgPath == null)
                        ? const Text('🙂')
                        : Image.file(File(imgPath!)),
                    radius: 60,
                  ),
                ),
              ),
              TextInputField(
                labelTextStr: 'Name',
                prefixIcon: Icons.person,
                initialValue: profile!.name,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    profile!.name = val;
                    return null;
                  }
                  return 'Please Input Name';
                },
              ),
              TextInputField(
                labelTextStr: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                initialValue: profile!.email,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    profile!.email = val;
                  }
                  return null;
                },
              ),
              TextInputField(
                labelTextStr: 'Mobile',
                prefixIcon: Icons.call,
                keyboardType: TextInputType.phone,
                initialValue: profile!.mobile,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    profile!.mobile = val;
                  }
                  return null;
                },
              ),
              const Divider(),
              const Center(child: Text('API Access Information')),
              const Divider(),
              TextInputField(
                labelTextStr: 'Website',
                prefixIcon: Icons.web,
                readOnly: true,
              ),
              TextInputField(
                labelTextStr: 'API Server Link',
                prefixIcon: Icons.map,
                readOnly: true,
              ),
              TextInputField(
                labelTextStr: 'Auth Key',
                prefixIcon: Icons.key,
                readOnly: true,
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
      Profile iPro = profile!;
      iPro.uid = uuid();
      iPro.save();

      final data = iPro.toString();
      log(data);
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
