// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/core.dart';
import '../../views/views.dart';

class EditLeadController extends StatelessController {
  const EditLeadController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Edit Lead',
      mobile: const EditLeadForMobile(),
    );
  }
}
