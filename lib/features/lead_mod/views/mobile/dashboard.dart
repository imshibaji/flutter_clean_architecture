import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  color: const Color.fromARGB(255, 247, 141, 3),
                  title: 'Followups / Activities',
                  pins: followups.isNotEmpty ? followups.length : 0,
                  onPress: () {
                    Nav.to(context, LeadApp.followup);
                  },
                ),
                shortcutButton(
                  color: Colors.blueGrey,
                  title: 'Deals / Proposals',
                  pins: deals.isNotEmpty ? deals.length : 0,
                  onPress: () {
                    Nav.to(context, LeadApp.listDeal);
                  },
                ),
                shortcutButton(
                  color: const Color.fromARGB(255, 31, 151, 95),
                  title: 'Converted Leads',
                  pins: leads.isNotEmpty
                      ? leads
                          .where((element) =>
                              element.status!.toLowerCase() == 'success')
                          .toList()
                          .length
                      : 0,
                  onPress: () {},
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
