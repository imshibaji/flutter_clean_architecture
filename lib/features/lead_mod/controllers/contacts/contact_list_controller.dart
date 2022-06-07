import 'package:flutter/material.dart';

import '../../../../core/classes/controller_manager.dart';
import '../../../../core/classes/display_manager.dart';
import '../../views/mobile/contacts/contact_list.dart';

class ContactListController extends StatelessController {
  const ContactListController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(title: 'Contact List', mobile: const ContactListPage());
  }
}
