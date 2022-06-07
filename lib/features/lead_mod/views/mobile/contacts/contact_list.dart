import 'package:clean_architecture/features/lead_mod/lead_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../../core/core.dart';
import '../../../utils/utils.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage>
    with AfterLayoutMixin<ContactListPage> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() {
        _contacts = null;
        _permissionDenied = true;
      });
      return;
    }

    await _refetchContacts();

    // Listen to DB changes
    FlutterContacts.addListener(() async {
      await _refetchContacts();
    });
  }

  Future _refetchContacts() async {
    // First load all contacts without photo
    await _loadContacts(false);

    // Next with photo
    await _loadContacts(true);
  }

  Future _loadContacts(bool withPhotos) async {
    final contacts = withPhotos
        ? (await FlutterContacts.getContacts(withThumbnail: true)).toList()
        : (await FlutterContacts.getContacts()).toList();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Phone Contacts')),
        body: _body(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => Navigator.of(context).pushNamed('/editContact'),
        //   child: const Icon(Icons.add),
        // ),
      );

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) {
          final contact = _contacts![i];
          return ListTile(
            leading: avatar(contact, 18.0),
            title: Text(contact.displayName),
            onTap: () => Nav.to(
              context,
              LeadApp.addLead,
              arguments: contact,
            ),
            // onLongPress: () => Navigator.of(context)
            //     .pushNamed(LeadApp.contactPage, arguments: contact),
          );
        });
  }
}
