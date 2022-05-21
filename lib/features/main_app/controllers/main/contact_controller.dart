import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../Screens/mobile/contact.dart' as mobile;
import '../../Screens/desktop/contact.dart' as desktop;
import '../../Screens/tablet/contact.dart' as tablet;

class ContactController extends StatelessController {
  final String _title = 'Contact Page';
  const ContactController({Key? key}) : super(key: key);

  @override
  bool get auth => false;

  @override
  Display view(BuildContext context) {
    return Display(
      title: _title,
      mobile: mobile.Contact(
        title: _title,
      ),
      tabletLandscape: tablet.Contact(title: _title),
      desktop: desktop.Contact(title: _title),
    );
  }
}
