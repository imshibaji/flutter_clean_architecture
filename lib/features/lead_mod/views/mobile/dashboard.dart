import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../lead_mod.dart';

class DashboardForMobile extends StatefulWidget {
  const DashboardForMobile({Key? key}) : super(key: key);

  @override
  State<DashboardForMobile> createState() => _DashboardForMobileState();
}

class _DashboardForMobileState extends State<DashboardForMobile> {
  List<TargetFocus> tergets = [];

  GlobalKey tabBar = GlobalKey();
  GlobalKey actionsButtons = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Dashboard'),
        actions: actionsMenu(context),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, sp, child) {
          var leads = sp.leads ?? [];
          var followups = sp.followups ?? [];
          var deals = sp.deals ?? [];

          return SizedBox(
            width: double.infinity,
            child: ListView(
              children: [
                balanceCard(
                  title: 'Balance:',
                  amount: getBalance(sp.payments ?? []).toK(),
                ),
                SizedBox(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ieCard(
                          color: const Color.fromARGB(255, 3, 236, 154),
                          assetsImageName: 'profits.svg',
                          amount: getTotalIncome(sp.payments ?? []).toK(),
                        ),
                        ieCard(
                          title: 'Expenses',
                          color: const Color.fromARGB(255, 254, 147, 147),
                          amount: getTotalExpense(sp.payments ?? []).toK(),
                        ),
                      ],
                    )),
                shortcutButton(
                  title: 'All Leads',
                  pins: leads.isNotEmpty ? leads.length : 0,
                  onPress: () {
                    Nav.to(context, LeadApp.listLeads);
                  },
                ),
                shortcutButton(
                  prefixIcon: Icons.attractions_outlined,
                  color: const Color.fromARGB(255, 247, 141, 3),
                  title: 'Followups / Activities',
                  pins: followups.isNotEmpty ? followups.length : 0,
                  onPress: () {
                    Nav.to(context, LeadApp.followup);
                  },
                ),
                shortcutButton(
                  prefixIcon: Icons.handshake_rounded,
                  color: Colors.blueGrey,
                  title: 'Deals / Proposals',
                  pins: deals.isNotEmpty ? deals.length : 0,
                  onPress: () {
                    Nav.to(context, LeadApp.listDeal);
                  },
                ),
                shortcutButton(
                  prefixIcon: Icons.accessibility_new,
                  color: const Color.fromARGB(255, 31, 151, 95),
                  title: 'Converted Leads',
                  pins: leads.isNotEmpty
                      ? leads
                          .where((element) =>
                              element.status!.toLowerCase() == 'success')
                          .toList()
                          .length
                      : 0,
                  onPress: () {
                    if (leads
                        .where((element) =>
                            element.status!.toLowerCase() == 'success')
                        .toList()
                        .isNotEmpty) {
                      Nav.go(LeadApp.listLeads, arguments: 'success');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: LeadAppBottomBar(key: tabBar),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   autofocus: true,
      //   tooltip: 'Add Lead',
      //   // mini: true,
      //   child: const Icon(Icons.person_add_alt),
      //   onPressed: () {
      //     Nav.to(context, LeadApp.addLead);
      //   },
      // ),
    );
  }

  void showTutorial() {}

  // Not Used
  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.teal,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Nav.toReplace(context, LeadApp.home);
                },
                icon: const Icon(
                  Icons.dashboard,
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Nav.toReplace(context, LeadApp.listLeads);
                },
                icon: Column(
                  children: const [
                    Icon(Icons.groups_outlined),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Nav.toReplace(context, LeadApp.listDeal);
                },
                icon: const Icon(Icons.payments),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Nav.toReplace(context, LeadApp.transactions);
                },
                icon: const Icon(Icons.account_balance_wallet_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
