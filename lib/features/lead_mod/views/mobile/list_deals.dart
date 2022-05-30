import 'package:flutter/material.dart';

import '../../../../core/core.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Proposals'),
        actions: actionsMenu(context),
      ),
      body: Column(
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
            child: ListView(children: [
              for (var i = 0; i < 10; i++) listItem(),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Padding listItem() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Row(
          children: [
            const Text('Deal Title'),
            const SizedBox(
              width: 5,
            ),
            StatusText(label: 'new'),
          ],
        ),
        subtitle: const Text('Deal Details'),
        shape: Border.all(width: 0.5),
        leading: const Icon(
          Icons.touch_app_sharp,
          size: 36,
        ),
        onTap: () {},
        trailing: IconButton(
          onPressed: () {
            setState(() {
              check = !check;
            });
          },
          icon: Icon(
            check ? Icons.check_box_outline_blank : Icons.check_box_outlined,
          ),
          tooltip: 'Delete Lead',
        ),
      ),
    );
  }
}
