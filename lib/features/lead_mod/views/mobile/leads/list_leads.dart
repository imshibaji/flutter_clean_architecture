import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../lead_app.dart';
import '../../../providers/providers.dart';
import '../../../widgets/widgets.dart';
import '../../../utils/utils.dart';

class ListLeadForMobile extends StatefulWidget {
  const ListLeadForMobile({Key? key}) : super(key: key);

  @override
  State<ListLeadForMobile> createState() => _ListLeadForMobileState();
}

class _ListLeadForMobileState extends State<ListLeadForMobile> {
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
          Nav.to(context, LeadApp.addLead);
        },
        child: const Icon(Icons.add_circle_outline_outlined),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, sp, child) => infoList(sp),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Widget infoList(ServiceProvider sp) {
    if (sp.leads != null) {
      return Column(
        children: [
          searchBar(),
          Container(
            color: Colors.teal.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ChipButton(label: 'New', onPressed: () {}),
                ChipButton(label: 'Pending', onPressed: () {}),
                ChipButton(label: 'Interested', onPressed: () {}),
                ChipButton(label: 'Success', onPressed: () {}),
                ChipButton(label: 'Rejected', onPressed: () {}),
                ChipButton(label: 'Expaired', onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: sp.leads!.length,
                itemBuilder: (context, index) {
                  // Data Aquare;
                  Lead lead = sp.leads![index];

                  String title = lead.name ?? 'No Name';
                  String details = (lead.purpose ?? 'No Details');

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
                      subtitle: Text("> " + details),
                      shape: Border.all(width: 0.5),
                      leading: const Icon(
                        Icons.person,
                        size: 36,
                      ),
                      onTap: () {
                        Nav.to(
                          context,
                          LeadApp.viewLead,
                          arguments: sp.leads![index],
                        );
                      },
                      trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => bottomMenus(lead, sp),
                          );
                        },
                        icon: const Icon(Icons.more_rounded),
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  SizedBox bottomMenus(Lead lead, ServiceProvider sp) {
    return SizedBox(
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.edit,
              color: Colors.orange,
            ),
            label: const Text(
              'Edit Lead',
              style: TextStyle(color: Colors.orange),
            ),
            onPressed: () {
              Nav.to(context, LeadApp.editLead, arguments: lead);
            },
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
            label: const Text(
              'Delete Lead',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Nav.close(context);
              confirmDialog(lead, sp);
            },
          ),
        ),
      ]),
    );
  }

  Future<void> confirmDialog(Lead lead, ServiceProvider sp) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is data will be deleted Permanently.'),
                Text('Re-Thinking about your action.'),
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
                // deleteData(index, sp);
                lead.delete();
                sp.getAllDeals();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteData(int id, ServiceProvider sp) async {
    // EnqueryService es = EnqueryService();
    // await es.delete(id);
    // ep.setEnquery();
    sp.deleteLead(id);
    showMessage(context, 'Lead Data Deleteted');
  }
}
