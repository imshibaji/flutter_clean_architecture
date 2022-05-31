import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../dbobj/dbobjs.dart';
import '../../lead_app.dart';
import '../../providers/providers.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ListDealForMobile extends StatefulWidget {
  const ListDealForMobile({Key? key}) : super(key: key);

  @override
  State<ListDealForMobile> createState() => _ListDealForMobileState();
}

class _ListDealForMobileState extends State<ListDealForMobile> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final sp = context.read<ServiceProvider>();
    sp.getAllDeals();
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Proposals'),
        actions: actionsMenu(context),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, sp, child) => Column(
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
                  ChipButton(label: 'Processing', onPressed: () {}),
                  ChipButton(label: 'Success', onPressed: () {}),
                  ChipButton(label: 'Rejected', onPressed: () {}),
                  ChipButton(label: 'Expaired', onPressed: () {}),
                ],
              ),
            ),
            Expanded(
              child: allDeals(sp.deals ?? [], sp),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  ListView allDeals(List<Deal> deals, ServiceProvider sp) {
    return ListView.builder(
      itemCount: deals.length,
      itemBuilder: (context, index) {
        Lead lead = sp.leads!.firstWhere(
          (element) => element.uid == deals[index].leadUid,
        );

        var dateTime =
            '${deals[index].createdAt!.day}/${deals[index].createdAt!.month}/${deals[index].createdAt!.year} ${deals[index].createdAt!.hour}:${deals[index].createdAt!.minute}';

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListTile(
            shape: Border.all(),
            onTap: () {
              Nav.to(context, LeadApp.viewLead, arguments: lead);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(deals[index].name!),
                Text(deals[index].price!.toString()),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deals[index].details!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lead.name! + ' | ' + dateTime),
                    StatusText(label: deals[index].status!),
                  ],
                )
              ],
            ),
            // leading: const Icon(
            //   Icons.note_alt_outlined,
            //   size: 30,
            // ),
            trailing: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => bottomMenus(deals[index], sp),
                );
              },
              icon: const Icon(
                Icons.blur_circular_sharp,
                size: 40,
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox bottomMenus(Deal deal, ServiceProvider sp) {
    return SizedBox(
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton.icon(
          icon: const Icon(
            Icons.share,
            color: Colors.green,
          ),
          label: const Text(
            'Share',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            Nav.close(context);
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.email,
            color: Colors.orange,
          ),
          label: const Text(
            'Email',
            style: TextStyle(color: Colors.orange),
          ),
          onPressed: () {
            Nav.close(context);
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.whatsapp,
            color: Colors.red,
          ),
          label: const Text(
            'Whatsapp',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Nav.close(context);
          },
        ),
      ]),
    );
  }
}
