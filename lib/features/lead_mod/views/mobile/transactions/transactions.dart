import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/payment.dart';
import '../../../lead_mod.dart';

class TransactionsForMobile extends StatefulWidget {
  const TransactionsForMobile({Key? key}) : super(key: key);

  @override
  State<TransactionsForMobile> createState() => _TransactionsForMobileState();
}

class _TransactionsForMobileState extends State<TransactionsForMobile> {
  bool check = false;
  String status = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Transactions'),
        actions: actionsMenu(context),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, sp, child) {
          return Column(children: [
            quickTotalView(sp),
            Container(
              color: Colors.teal.withOpacity(0.4),
              padding: const EdgeInsets.all(10),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ChipButton(
                      label: 'All',
                      onPressed: () => setStatus('All'),
                    ),
                  ),
                  for (String status in transactonsStatuses)
                    Expanded(
                      child: ChipButton(
                        label: status,
                        onPressed: () => setStatus(status),
                      ),
                    ),
                ],
              ),
            ),
            transectionsList(sp.payments!),
          ]);
        },
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTransactionAdd(context);
        },
        child: const Icon(Icons.add_chart_sharp),
      ),
    );
  }

  Expanded transectionsList(List<Payment> payments) {
    List trans = getTransactionFilter(payments, status);
    return Expanded(
      child: trans.isNotEmpty
          ? ListView.builder(
              itemCount: trans.length,
              itemBuilder: (context, index) => listItem(
                context,
                trans[index],
              ),
            )
          : const Center(
              child: Text('No Transection Listed.'),
            ),
    );
  }

  void setStatus(String stat) {
    setState(() {
      status = stat;
    });
  }

  Padding listItem(BuildContext context, Payment payment) {
    var pct = payment.createdAt!;
    var dateTime =
        '${pct.day}/${pct.month}/${pct.year} ${pct.hour}:${pct.minute}';
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatusText(
              label: payment.type ?? 'Income',
              size: 10,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(payment.details ?? 'No Details'),
            Text(
              'At: ' + dateTime,
              style: const TextStyle(fontSize: 9),
            ),
          ],
        ),
        shape: Border.all(width: 0.5),
        leading: const Icon(
          Icons.monetization_on_outlined,
          size: 36,
        ),
        trailing: Text(payment.amount.toString()),
        onTap: () {},
      ),
    );
  }
}
