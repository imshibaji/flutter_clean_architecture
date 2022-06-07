import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../../core/core.dart';
import '../../../utils/avatar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with AfterLayoutMixin<ContactPage> {
  Contact? _contact;

  @override
  void afterFirstLayout(BuildContext context) {
    // final contact = ModalRoute.of(context)!.settings.arguments as Contact;
    final contact = Nav.routeData(context) as Contact;
    setState(() {
      _contact = contact;
    });
    _fetchContact();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact?.displayName ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(prettyJson(_contact!
                      .toJson(withPhoto: false, withThumbnail: false))),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_present),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(
                      _contact!.toVCard(withPhoto: false, includeDate: true)),
                ),
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: _contact, child: const Text('Delete contact'))
            ],
            onSelected: (Contact contact) async {
              await contact.delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _body(_contact!),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed('/editContact', arguments: {
          'contact': _contact,
          // A better solution would be to make [ContactPage] listen to DB
          // changes, but this will do for now
          'onUpdate': _fetchContact,
        }),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _body(Contact contact) {
    if (_contact?.name == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _withSpacing([
          Center(child: avatar(contact)),
          _makeCard(
              'ID',
              [contact],
              (x) => [
                    const Divider(),
                    Text('ID: ${x.id}'),
                    Text('Display name: ${x.displayName}'),
                    Text('Starred: ${x.isStarred}'),
                  ]),
          _makeCard(
              'Name',
              [contact.name],
              (x) => [
                    const Divider(),
                    Text('Prefix: ${x.prefix}'),
                    Text('First: ${x.first}'),
                    Text('Middle: ${x.middle}'),
                    Text('Last: ${x.last}'),
                    Text('Suffix: ${x.suffix}'),
                    Text('Nickname: ${x.nickname}'),
                    Text('Phonetic first: ${x.firstPhonetic}'),
                    Text('Phonetic middle: ${x.middlePhonetic}'),
                    Text('Phonetic last: ${x.lastPhonetic}'),
                  ]),
          _makeCard(
              'Phones',
              contact.phones,
              (x) => [
                    const Divider(),
                    Text('Number: ${x.number}'),
                    Text('Normalized number: ${x.normalizedNumber}'),
                    Text('Label: ${x.label}'),
                    Text('Custom label: ${x.customLabel}'),
                    Text('Primary: ${x.isPrimary}')
                  ]),
          _makeCard(
              'Emails',
              contact.emails,
              (x) => [
                    const Divider(),
                    Text('Address: ${x.address}'),
                    Text('Label: ${x.label}'),
                    Text('Custom label: ${x.customLabel}'),
                    Text('Primary: ${x.isPrimary}')
                  ]),
          _makeCard(
              'Addresses',
              contact.addresses,
              (x) => [
                    const Divider(),
                    Text('Address: ${x.address}'),
                    Text('Label: ${x.label}'),
                    Text('Custom label: ${x.customLabel}'),
                    Text('Street: ${x.street}'),
                    Text('PO box: ${x.pobox}'),
                    Text('Neighborhood: ${x.neighborhood}'),
                    Text('City: ${x.city}'),
                    Text('State: ${x.state}'),
                    Text('Postal code: ${x.postalCode}'),
                    Text('Country: ${x.country}'),
                    Text('ISO country: ${x.isoCountry}'),
                    Text('Sub admin area: ${x.subAdminArea}'),
                    Text('Sub locality: ${x.subLocality}'),
                  ]),
          _makeCard(
              'Organizations',
              contact.organizations,
              (x) => [
                    const Divider(),
                    Text('Company: ${x.company}'),
                    Text('Title: ${x.title}'),
                    Text('Department: ${x.department}'),
                    Text('Job description: ${x.jobDescription}'),
                    Text('Symbol: ${x.symbol}'),
                    Text('Phonetic name: ${x.phoneticName}'),
                    Text('Office location: ${x.officeLocation}'),
                  ]),
          _makeCard(
              'Websites',
              contact.websites,
              (x) => [
                    const Divider(),
                    Text('URL: ${x.url}'),
                    Text('Label: ${x.label}'),
                    Text('Custom label: ${x.customLabel}'),
                  ]),
          _makeCard(
              'Social medias',
              contact.socialMedias,
              (x) => [
                    const Divider(),
                    Text('Value: ${x.userName}'),
                    Text('Label: ${x.label}'),
                    Text('Custom label: ${x.customLabel}'),
                  ]),
          _makeCard(
              'Events',
              contact.events,
              (x) => [
                    const Divider(),
                    Text('Date: ${_formatDate(x)}'),
                    Text('Label: ${x.label}'),
                    Text('Custom label: ${x.customLabel}'),
                  ]),
          _makeCard(
              'Notes',
              contact.notes,
              (x) => [
                    const Divider(),
                    Text('Note: ${x.note}'),
                  ]),
          _makeCard(
              'Groups',
              contact.groups,
              (x) => [
                    const Divider(),
                    Text('Group ID: ${x.id}'),
                    Text('Name: ${x.name}'),
                  ]),
          _makeCard(
              'Accounts',
              contact.accounts,
              (x) => [
                    const Divider(),
                    Text('Raw IDs: ${x.rawId}'),
                    Text('Type: ${x.type}'),
                    Text('Name: ${x.name}'),
                    Text('Mimetypes: ${x.mimetypes}'),
                  ]),
          _makeCard(
              'Raw JSON',
              [contact],
              (x) => [
                    const Divider(),
                    Text(
                      prettyJson(
                        x.toJson(withThumbnail: false, withPhoto: false),
                      ),
                    ),
                  ]),
        ]),
      ),
    );
  }

  String _formatDate(Event e) =>
      '${e.year?.toString().padLeft(4, '0') ?? '--'}/'
      '${e.month.toString().padLeft(2, '0')}/'
      '${e.day.toString().padLeft(2, '0')}';

  List<Widget> _withSpacing(List<Widget> widgets) {
    const spacer = SizedBox(height: 8);
    return <Widget>[spacer] +
        widgets.map((p) => [p, spacer]).expand((p) => p).toList();
  }

  Card _makeCard(
      String title, List fields, List<Widget> Function(dynamic) mapper) {
    var elements = <Widget>[];
    for (var field in fields) {
      elements.addAll(mapper(field));
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _withSpacing(<Widget>[
                Text(title, style: const TextStyle(fontSize: 22)),
              ] +
              elements),
        ),
      ),
    );
  }
}
