// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class TransactionsController extends StatelessController {
  const TransactionsController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Transactions',
      mobile: const TransactionsForMobile(),
    );
  }
}
