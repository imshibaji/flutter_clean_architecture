// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class ListEnqueryController extends StatelessController {
  const ListEnqueryController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Enqueries / Lead',
      mobile: const ListEnqueryForMobile(),
    );
  }
}
