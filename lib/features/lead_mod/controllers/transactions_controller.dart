import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../lead_mod.dart';

class TransactionsController extends StatelessController {
  const TransactionsController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    final sp = context.read<ServiceProvider>();
    sp.getAllPayments();
    return Display(
      title: 'Transactions',
      mobile: const TransactionsForMobile(),
    );
  }
}
