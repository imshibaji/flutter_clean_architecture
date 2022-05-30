// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/core.dart';
import '../../views/views.dart';

class AddEnqueryController extends StatelessController {
  const AddEnqueryController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Add New Enquery',
      mobile: const AddEnqueryForMobile(),
    );
  }
}
