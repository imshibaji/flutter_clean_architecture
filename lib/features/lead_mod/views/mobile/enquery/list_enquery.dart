import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../lead_mod.dart';

class ListEnqueryForMobile extends StatefulWidget {
  const ListEnqueryForMobile({Key? key}) : super(key: key);

  @override
  State<ListEnqueryForMobile> createState() => _ListEnqueryForMobileState();
}

class _ListEnqueryForMobileState extends State<ListEnqueryForMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Enqueries'),
        actions: actionsMenu(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.to(context, LeadApp.addEnquery);
        },
        child: const Icon(Icons.add_circle_outline_outlined),
      ),
      body: Consumer<EnqueryProvider>(
        builder: (context, ep, child) => infoList(ep),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Widget infoList(EnqueryProvider ep) {
    if (ep.enqueries != null) {
      return ListView.builder(
          itemCount: ep.enqueries!.length,
          itemBuilder: (context, index) {
            // Data Aquare;
            Lead lead = ep.enqueries![index].attributes!;

            String title = lead.customer_name ?? 'No Name';
            String details = (lead.customer_email ?? 'No Email') +
                ' | ' +
                (lead.customer_mobile ?? 'No Number');

            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
                title: Row(
                  children: [
                    Text(title),
                    const SizedBox(
                      width: 5,
                    ),
                    StatusText(label: lead.status!),
                  ],
                ),
                subtitle: Text(details),
                shape: Border.all(width: 0.5),
                leading: const Icon(
                  Icons.touch_app_sharp,
                  size: 36,
                ),
                onTap: () {
                  Nav.to(
                    context,
                    LeadApp.viewEnquery,
                    arguments: ep.enqueries![index],
                  );
                },
                trailing: IconButton(
                  onPressed: () {
                    confirmDialog(ep.enqueries![index], ep);
                  },
                  icon: const Icon(Icons.delete_forever),
                  tooltip: 'Delete Lead',
                ),
              ),
            );
          });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Future<void> confirmDialog(EnqueryData ed, EnqueryProvider ep) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is data will be deleted from the Server.'),
                Text('Rethinking about your acction.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteData(ed.id!, ep);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteData(int id, EnqueryProvider ep) async {
    EnqueryService es = EnqueryService();
    await es.delete(id);
    ep.setEnquery();
    showMessage(context, 'Lead Data Deleteted');
  }
}
