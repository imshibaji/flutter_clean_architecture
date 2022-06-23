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
  final PageController _controller = PageController();
  int pageIndex = 0;

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
              padding: const EdgeInsets.all(0),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ChipButton(
                      label: 'All',
                      onPressed: () => _controller.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                      isHighlight: (pageIndex == 0),
                    ),
                  ),
                  for (int i = 0; i < transactonsStatuses.length; i++)
                    Expanded(
                      child: ChipButton(
                        label: transactonsStatuses[i],
                        onPressed: () => _controller.animateToPage(
                          (i + 1),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                        isHighlight: (pageIndex == (i + 1)),
                      ),
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
                  transectionsList(
                    getTransactionFilter(sp.payments!, 'All') as List<Payment>,
                  ),
                  for (String status in transactonsStatuses)
                    transectionsList(
                      getTransactionFilter(sp.payments!, status)
                          as List<Payment>,
                      notFoundTxt: 'No $status Transection Listed.',
                    ),
                ],
              ),
            ),
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

  Widget transectionsList(
    List<Payment> payments, {
    String notFoundTxt = 'No Transection Listed.',
  }) {
    List trans = payments;
    return Container(
      child: trans.isNotEmpty
          ? ListView.builder(
              itemCount: trans.length,
              itemBuilder: (context, index) => listItem(
                context,
                trans[index],
              ),
            )
          : Center(
              child: Text(notFoundTxt),
            ),
    );
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
              size: 9,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (payment.details ?? 'No Details').substring(
                0,
                (payment.details!.length > 50) ? 5 : payment.details!.length,
              ),
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.left,
            ),
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
