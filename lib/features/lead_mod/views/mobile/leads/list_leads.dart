import 'dart:async';
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

class _ListLeadForMobileState extends State<ListLeadForMobile>
    with AfterLayoutMixin {
  int pageIndex = 0;
  final PageController _controller = PageController();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    goto(context);
  }

  void goto(BuildContext context) {
    String? type = Nav.routeData<String>(context);
    if (type != null && type.isNotEmpty) {
      for (var i = 0; i < leadStatuses.length; i++) {
        if (leadStatuses[i].toLowerCase() == type.toLowerCase()) {
          _controller.animateToPage(
            (i + 1),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInSine,
          );
        }
      }
    }
  }

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
        child: const Icon(Icons.person_add_alt),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, sp, child) => infoList(sp),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Widget infoList(ServiceProvider sp) {
    return Column(
      children: [
        // searchBar(),
        Container(
          color: Colors.teal.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ChipButton(
                label: 'All',
                onPressed: () => _controller.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInSine),
                isHighlight: (pageIndex == 0),
              ),
              for (var i = 0; i < leadStatuses.length; i++)
                ChipButton(
                  label: leadStatuses[i],
                  onPressed: () => _controller.animateToPage(
                    (i + 1),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInSine,
                  ),
                  isHighlight: (pageIndex == (i + 1)),
                ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (pIndex) {
              setState(() {
                pageIndex = pIndex;
              });
            },
            children: [
              leadList(getFilterDatas(sp.leads!.reversed.toList(), 'All'), sp),
              for (String status in leadStatuses)
                leadList(
                  getFilterDatas(sp.leads!.reversed.toList(), status),
                  sp,
                  notFound: 'No $status list found..',
                ),
            ],
          ),
        ),
      ],
    );
  }

  Container leadList(List<dynamic> leads, ServiceProvider sp,
      {String notFound = 'No Leads Listed..'}) {
    return Container(
      child: leads.isNotEmpty
          ? ListView.builder(
              itemCount: leads.length,
              itemBuilder: (context, index) {
                // Data Aquare;
                Lead lead = leads[index];

                String title = lead.name ?? 'No Name';
                String details = (lead.purpose ?? 'No Details');

                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    title: Text(title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(fontSize: 8),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            StatusText(
                              label: lead.status!,
                              size: 8,
                            ),
                          ],
                        ),
                        Text("> " + details),
                      ],
                    ),
                    shape: Border.all(width: 0.5),
                    leading: const Icon(
                      Icons.person,
                      size: 36,
                    ),
                    onTap: () {
                      Nav.to(
                        context,
                        LeadApp.viewLead,
                        arguments: lead,
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
              })
          : Center(child: Text(notFound)),
    );
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
                deleteData(lead, sp);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteData(Lead lead, ServiceProvider sp) async {
    if (lead.deals != null) await lead.deals!.deleteAllFromHive();
    if (lead.followups != null) await lead.followups!.deleteAllFromHive();
    await lead.delete();
    await sp.getAllLeads();
    Navigator.of(context).pop();
    showMessage(context, 'Lead Data Deleteted');
  }
}
