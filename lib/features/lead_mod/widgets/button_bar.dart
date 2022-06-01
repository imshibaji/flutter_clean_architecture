import 'package:flutter/material.dart';

import '../../../core/utils/button_data.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../lead_mod.dart';

// ignore: must_be_immutable
class LeadAppBottomBar extends BottomBar {
  LeadAppBottomBar({Key? key})
      : super(key: key, buttonDatas: [
          ButtonData(
            icon: Icons.dashboard,
            label: 'Dashboard',
            link: LeadApp.home,
          ),
          ButtonData(
            icon: Icons.groups_outlined,
            label: 'Leads',
            link: LeadApp.listLeads,
          ),
          ButtonData(
            icon: Icons.tty_sharp,
            label: 'Followup',
            link: LeadApp.followup,
          ),
          ButtonData(
            icon: Icons.payments,
            label: 'Deals',
            link: LeadApp.listDeal,
          ),
          ButtonData(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Account',
            link: LeadApp.transactions,
          ),
        ]);
}
