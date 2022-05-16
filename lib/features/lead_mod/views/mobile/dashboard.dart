import 'package:flutter/material.dart';
import 'package:lead_book/core/core.dart';
import 'package:lead_book/features/lead_mod/widgets/button_bar.dart';

class DashboardForMobile extends StatelessWidget {
  const DashboardForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }
}
