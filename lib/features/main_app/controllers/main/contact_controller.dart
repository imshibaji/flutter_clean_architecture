import 'package:flutter/material.dart';

import '../../Screens//mobile/contact.dart' as mobile;
import '../../Screens/tablet/contact.dart' as tablet;
import '../../Screens/desktop/contact.dart' as desktop;

class ContactController extends StatelessWidget {
  final String _title = 'Contact Page';
  const ContactController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Container(
      child: width < 500
          ? mobile.Contact(
              title: _title,
            )
          : width < 1024
              ? tablet.Contact(
                  title: _title,
                )
              : desktop.Contact(
                  title: _title,
                ),
    );
  }
}
