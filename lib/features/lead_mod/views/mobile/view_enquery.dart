import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_theme.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../lead_app.dart';
import '../../widgets/button_bar.dart';

class ViewEnqueryForMobile extends StatelessWidget {
  const ViewEnqueryForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.home);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('View Lead'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      body: Column(
        children: [
          Stack(
            children: [
              leadInformation(context),
              Positioned(
                right: 0,
                child: ElevatedButton(
                  onPressed: () {
                    Nav.to(context, LeadApp.editEnquery);
                  },
                  child: const Icon(
                    Icons.touch_app_sharp,
                  ),
                ),
              )
            ],
          ),
          followupTasks(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => followupForm(),
          );
        },
        child: const Icon(Icons.add_task_sharp),
      ),
    );
  }

  Expanded followupTasks() {
    return Expanded(
        child: ListView(
      children: [
        for (var i = 0; i < 10; i++)
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              shape: Border.all(),
              title: const Text('pending'),
              subtitle: const Text(
                'Customers need demo session. Customers need demo session. Customers need demo session.',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              leading: const Icon(
                Icons.task_alt,
                size: 30,
              ),
            ),
          ),
      ],
    ));
  }

  Form followupForm() {
    return Form(
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Discuss Details',
            ),
            const SizedBox(
              height: 15,
            ),
            SelectOptionField(
              prefixIcon: Icons.water_drop_outlined,
              labelTextStr: 'Status',
              options: const [
                'new',
                'pending',
                'success',
                'rejected',
                'expaired',
              ],
              selected: 'new',
            ),
            Row(
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: () {},
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container leadInformation(BuildContext context) {
    var tp = Provider.of<ThemeProvider>(context);
    return Container(
      color: tp.isDarkMode == false
          ? Theme.of(context).primaryColorLight
          : Colors.black26,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      height: 180,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: const [
                Icon(
                  Icons.edit_note,
                  size: 32,
                ),
                Text(
                  'Shaymal Kanty',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: const [
                Icon(
                  Icons.email,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'shyamal@gmail.com',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: const [
                Icon(
                  Icons.phone_android_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '+91-89812287739',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: const [
                Icon(
                  Icons.task_alt,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'I need a Good Website Design for School Website. This based Unique Degign. with Fullstack Development',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
