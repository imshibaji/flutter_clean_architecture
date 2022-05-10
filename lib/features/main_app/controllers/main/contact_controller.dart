import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:flutter/material.dart';

import '../../Screens//mobile/contact.dart' as mobile;
import '../../Screens/tablet/contact.dart' as tablet;
import '../../Screens/desktop/contact.dart' as desktop;

class ContactController extends StatelessWidget {
  final String _title = 'Contact Page';
  const ContactController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Display(
      title: _title,
      xs: mobile.Contact(
        title: _title,
      ),
      md: tablet.Contact(title: _title),
      lg: desktop.Contact(title: _title),
    );
  }
}
