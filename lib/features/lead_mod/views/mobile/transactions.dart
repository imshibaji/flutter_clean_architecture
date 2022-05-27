import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../lead_mod.dart';

class TransactionsForMobile extends StatelessWidget {
  const TransactionsForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Transactions'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
