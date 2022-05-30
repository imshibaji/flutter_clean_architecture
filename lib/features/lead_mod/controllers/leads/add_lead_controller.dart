// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/core.dart';
import '../../views/views.dart';

class AddLeadController extends StatelessController {
  const AddLeadController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Add New Enquery',
      mobile: const AddLeadForMobile(),
    );
  }
}
