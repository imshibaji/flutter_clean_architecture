// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/core.dart';
import '../../views/views.dart';

class ViewLeadController extends StatelessController {
  const ViewLeadController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(title: 'View Lead', mobile: const ViewLeadForMobile());
  }
}
