import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
import '../../lead_mod.dart';

class DashboardForMobile extends StatefulWidget {
  const DashboardForMobile({Key? key}) : super(key: key);

  @override
  State<DashboardForMobile> createState() => _DashboardForMobileState();
}

class _DashboardForMobileState extends State<DashboardForMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Dashboard'),
        actions: actionsMenu(context),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(children: [
          balanceCard(
            title: 'Balance:',
            amount: '8k',
          ),
          SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ieCard(
                      color: const Color.fromARGB(255, 3, 236, 154),
                      assetsImageName: 'profits.svg',
                      amount: '10k'),
                  ieCard(
                    title: 'Expenses',
                    color: const Color.fromARGB(255, 254, 147, 147),
                    amount: '2k',
                  ),
                ],
              )),

          shortcutButton(
            pins: 200,
          ),
          shortcutButton(
            color: const Color.fromARGB(255, 247, 141, 3),
            title: 'Followups / Activities',
            pins: 152,
            onPress: () {},
          ),
          // shortcutButton(
          //   color: Colors.grey,
          //   title: 'Followups Processing',
          //   pins: 24,
          //   onPress: () {},
          // ),
          shortcutButton(
            color: Colors.blueGrey,
            title: 'New Deals / Proposals',
            pins: 24,
            onPress: () {},
          ),
          shortcutButton(
            color: const Color.fromARGB(255, 31, 151, 95),
            title: 'Converted Leads',
            pins: 12,
            onPress: () {},
          ),
        ]),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  SizedBox balanceCard({
    String assetsImageName = 'balance.svg',
    Color color = Colors.amber,
    String title = 'Balance',
    String amount = '1,000.00',
  }) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            color: color,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/' + assetsImageName,
                width: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 34,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 34,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded ieCard({
    String assetsImageName = 'expense.svg',
    Color color = Colors.amber,
    String title = 'Income',
    String amount = '1,000.00',
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            color: color,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/' + assetsImageName,
                width: 60,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 34,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell shortcutButton({
    Color color = const Color.fromARGB(255, 233, 11, 107),
    String title = 'New Leads',
    int pins = 0,
    void Function()? onPress,
  }) {
    return InkWell(
      onTap: () => onPress!(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            color: color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(radius: 25, backgroundColor: Colors.white),
                  Text(
                    pins.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
