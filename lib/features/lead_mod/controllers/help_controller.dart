import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class HelpController extends StatelessController {
  const HelpController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'LeadsBook - Helps',
      mobile: const HelpMobileView(),
    );
  }
}
