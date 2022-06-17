import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../lead_app.dart';
import '../../../providers/providers.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class FollowupForMobile extends StatefulWidget {
  const FollowupForMobile({Key? key}) : super(key: key);

  @override
  State<FollowupForMobile> createState() => _FollowupForMobileState();
}

class _FollowupForMobileState extends State<FollowupForMobile> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Followups'),
        actions: actionsMenu(context),
      ),
      body: Consumer<ServiceProvider>(builder: (context, sp, child) {
        return Column(
          children: [
            // searchBar(),
            Container(
              color: Colors.teal.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ChipButton(
                      label: 'Pending',
                      onPressed: () => _controller.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInQuad),
                    ),
                  ),
                  Expanded(
                    child: ChipButton(
                      label: 'Done',
                      onPressed: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInQuad),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  followupList(
                    getFollowupFilter(sp.followups!, false),
                    sp,
                    notFoundTxt: 'No Pending Followup Data Found',
                  ),
                  followupList(
                    getFollowupFilter(sp.followups!, true),
                    sp,
                    notFoundTxt: 'No Done Followup Data Found',
                  ),
                ],
              ),
            )
          ],
        );
      }),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Container followupList(List<Followup> followups, ServiceProvider sp,
      {String notFoundTxt = 'No Followup Data Found'}) {
    return Container(
      child: followups.isNotEmpty
          ? ListView.builder(
              itemCount: followups.length,
              itemBuilder: (context, index) => listItem(followups[index], sp),
            )
          : Center(
              child: Text(notFoundTxt),
            ),
    );
  }

  Padding listItem(Followup followup, ServiceProvider sp) {
    Lead lead = sp.leads!.firstWhere(
      (element) => element.uid == followup.leadUid,
    );

    var dateTime =
        '${followup.schedule!.day}/${followup.schedule!.month}/${followup.schedule!.year} ${followup.schedule!.hour}:${followup.schedule!.minute}';

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(followup.discuss ?? 'Deal Title'),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(lead.purpose ?? 'No Purpose'),
                const SizedBox(
                  width: 6,
                ),
                StatusText(label: followup.status ?? 'new')
              ],
            ),
            Text((lead.name ?? 'No Name') + ' | ' + dateTime)
          ],
        ),
        shape: Border.all(width: 0.5),
        leading: InkWell(
          child: (followup.isDone == true)
              ? const Icon(
                  Icons.task_alt_sharp,
                  size: 36,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.not_interested_sharp,
                  size: 36,
                  color: Colors.orange,
                ),
          onTap: () {
            Nav.to(context, LeadApp.viewLead, arguments: lead);
          },
        ),
        onLongPress: () {
          Nav.to(context, LeadApp.viewLead, arguments: lead);
        },
        onTap: () {
          showFollowupBottomMenu(context, lead, followup, sp);
        },
        trailing: IconButton(
          onPressed: () {
            showFollowupBottomMenu(context, lead, followup, sp);
          },
          icon: const Icon(Icons.more_rounded),
        ),
      ),
    );
  }
}
