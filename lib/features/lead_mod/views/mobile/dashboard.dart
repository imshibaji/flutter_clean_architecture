import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../lead_mod.dart';

class DashboardForMobile extends StatefulWidget {
  const DashboardForMobile({Key? key}) : super(key: key);

  @override
  State<DashboardForMobile> createState() => _DashboardForMobileState();
}

class _DashboardForMobileState extends State<DashboardForMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const LeadAppDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: _openDrawer,
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Enqueries / Leads'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.to(context, LeadApp.addEnquery);
        },
        child: const Icon(Icons.add_circle_outline_outlined),
      ),
      body: Consumer<EnqueryProvider>(
        builder: (context, ep, child) => infoList(ep),
      ),
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

            return ListTile(
              title: Text(title),
              subtitle: Text(details),
              trailing: IconButton(
                onPressed: () {
                  Nav.to(context, LeadApp.editEnquery);
                },
                icon: const Icon(Icons.edit),
              ),
            );
          });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
