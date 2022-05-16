import 'package:flutter/material.dart';
import 'package:lead_book/core/helpers/actions_helper.dart';
import 'package:lead_book/features/lead_mod/widgets/button_bar.dart';

class AboutForMobile extends StatelessWidget {
  const AboutForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
