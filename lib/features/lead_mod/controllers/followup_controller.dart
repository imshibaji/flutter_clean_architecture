import 'package:clean_architecture/features/lead_mod/views/mobile/followup.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class FollowupController extends StatelessController {
  const FollowupController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'Followup Section',
      mobile: const FollowupForMobile(),
    );
  }
}
