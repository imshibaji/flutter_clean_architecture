import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../lead_mod.dart';

class TransactionsForMobile extends StatefulWidget {
  const TransactionsForMobile({Key? key}) : super(key: key);

  @override
  State<TransactionsForMobile> createState() => _TransactionsForMobileState();
}

class _TransactionsForMobileState extends State<TransactionsForMobile> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Transactions'),
        actions: actionsMenu(context),
      ),
      body: Column(children: [
        searchBar(),
        Container(
          color: Colors.teal.withOpacity(0.4),
          padding: const EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: ChipButton(label: 'Income', onPressed: () {})),
              Expanded(child: ChipButton(label: 'Expense', onPressed: () {})),
            ],
          ),
        ),
        Expanded(
          child: ListView(children: [
            for (var i = 0; i < 10; i++) listItem(),
          ]),
        ),
      ]),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Padding listItem() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Row(
          children: [
            const Text('Cash Received'),
            const SizedBox(
              width: 5,
            ),
            StatusText(label: 'Income'),
          ],
        ),
        subtitle: const Text('Training Advanced Payments Received from Arnab'),
        shape: Border.all(width: 0.5),
        leading: const Icon(
          Icons.monetization_on_outlined,
          size: 36,
        ),
        onTap: () {},
        trailing: const Text('20000'),
      ),
    );
  }
}
