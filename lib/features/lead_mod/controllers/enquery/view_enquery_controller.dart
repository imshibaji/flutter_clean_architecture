// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/core.dart';
import '../../views/views.dart';

class ViewEnqueryController extends StatelessController {
  const ViewEnqueryController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'View Enqueries',
      mobile: const ViewEnqueryForMobile(),
    );
  }
}
