import 'package:clean_archetructure/classes/route_manager.dart';
import 'package:clean_archetructure/features/main_app/widgets/bottom_bar.dart';
import 'package:clean_archetructure/features/main_app/widgets/day_night_switch.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  final String? title;
  const Contact({Key? key, this.title}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: const [DayNightSwitch()],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('This is the first page'),
            ElevatedButton(
              onPressed: () {
                Nav.to(context, '/');
              },
              child: const Text('Goto Home Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Nav.to(context, '/about');
              },
              child: const Text('Goto About Page'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
