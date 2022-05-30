import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../dbobj/dbobjs.dart';
import '../../lead_app.dart';
import '../../utils/utils.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FollowupForMobile extends StatefulWidget {
  const FollowupForMobile({Key? key}) : super(key: key);

  @override
  State<FollowupForMobile> createState() => _FollowupForMobileState();
}

class _FollowupForMobileState extends State<FollowupForMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Followups'),
        actions: actionsMenu(context),
      ),
      body: Consumer<ServiceProvider>(builder: (context, sp, child) {
        sp.getAllFollowups();
        if (sp.followups != null) {
          return Column(
            children: [
              searchBar(),
              Container(
                color: Colors.teal.withOpacity(0.4),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
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
                  itemCount: sp.followups!.length,
                  itemBuilder: (context, index) =>
                      listItem(sp.followups![index], sp),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Padding listItem(Followup followup, ServiceProvider sp) {
    sp.getAllLeads();
    Lead lead = sp.leads!.firstWhere(
      (element) => element.uid == followup.leadUid,
    );

    var dateTime =
        '${followup.schedule!.day}/${followup.schedule!.month}/${followup.schedule!.year} ${followup.schedule!.hour}:${followup.schedule!.minute}';
    var detailOfLead = (lead.name! + ' | ' + lead.purpose! + ' | ' + dateTime);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Row(
          children: [
            Text(followup.discuss ?? 'Deal Title'),
            const SizedBox(
              width: 5,
            ),
            StatusText(label: followup.status ?? 'new'),
          ],
        ),
        subtitle: Text(detailOfLead),
        shape: Border.all(width: 0.5),
        leading: const Icon(
          Icons.touch_app_sharp,
          size: 36,
        ),
        onTap: () {
          Nav.to(context, LeadApp.viewLead, arguments: lead);
        },
        trailing: IconButton(
          onPressed: () {
            confirmDialog(followup, sp);
          },
          icon: const Icon(
            Icons.delete_forever,
          ),
          tooltip: 'Delete Lead',
        ),
      ),
    );
  }

  Future<void> confirmDialog(Followup followup, ServiceProvider sp) async {
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
                followup.delete();
                sp.getAllFollowups();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
