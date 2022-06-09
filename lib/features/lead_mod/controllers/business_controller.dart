import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class BusinessController extends StatelessController {
  const BusinessController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'LeadsBook - Business',
      mobile: const BusinessMobileView(),
    );
  }
}
