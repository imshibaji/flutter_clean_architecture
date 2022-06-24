import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class ProfileController extends StatelessController {
  const ProfileController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'LeadsBook - Profile',
      mobile: const OwnerProfileMobileView(),
    );
  }
}
