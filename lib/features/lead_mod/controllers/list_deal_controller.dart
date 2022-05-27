// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class ListDealController extends StatelessController {
  const ListDealController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Proposals / Deals',
      mobile: const ListDealForMobile(),
    );
  }
}
