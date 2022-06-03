import 'lead_mod_utilities.dart';
import 'package:flutter/material.dart';

import '../../../core/classes/classes.dart';
import '../../../core/utils/utils.dart';
import '../dbobj/dbobjs.dart';
import '../providers/providers.dart';

const followupStatuses = [
  'Pending',
  'Interested',
  'Success',
  'Rejected',
  'Expaired',
];

List<Followup> getFollowupFilter(List<Followup> list, [bool status = false]) {
  return list.where((element) => element.isDone == status).toList();
}

void showFollowupBottomMenu(
    BuildContext context, Lead lead, Followup followup, ServiceProvider sp) {
  showModalBottomSheet(
    context: context,
    builder: (_) => bottomFollowupMenus(context, lead, followup, sp),
  );
}

SizedBox bottomFollowupMenus(
    BuildContext context, Lead lead, Followup followup, ServiceProvider sp) {
  return SizedBox(
    height: 50,
    child: ListView(scrollDirection: Axis.horizontal, children: [
      IconButton(
        icon: const Icon(
          Icons.call,
          color: Colors.blue,
        ),
        onPressed: () {
          makePhoneCall(lead.mobile!);
          Nav.close(context);
        },
      ),
      // IconButton(
      //   icon: const Icon(
      //     Icons.whatsapp,
      //     color: Colors.green,
      //   ),
      //   onPressed: () {
      //     Nav.close(context);
      //   },
      // ),
      IconButton(
        icon: const Icon(
          Icons.email,
          color: Colors.orange,
        ),
        onPressed: () {
          mailTo(lead.email!);
          Nav.close(context);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.done,
          color: Colors.green,
        ),
        label: const Text(
          'Done Task',
          style: TextStyle(color: Colors.green),
        ),
        onPressed: () {
          followup.isDone = true;
          followup.save();

          sp.getAllFollowups();

          Nav.close(context);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.close,
          color: Colors.orange,
        ),
        label: const Text(
          'Not Done',
          style: TextStyle(color: Colors.orange),
        ),
        onPressed: () {
          followup.isDone = false;
          followup.save();

          sp.getAllFollowups();

          Nav.close(context);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.delete_outline_outlined,
          color: Colors.red,
        ),
        label: const Text(
          'Delete Task',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Nav.close(context);
          deleteConfirmDialog(
            context,
            onAction: () {
              followup.delete();
              sp.getAllFollowups();
            },
          );
        },
      ),
    ]),
  );
}
