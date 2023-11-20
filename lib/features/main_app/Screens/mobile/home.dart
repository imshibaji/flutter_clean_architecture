import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';

class Home extends StatefulWidget {
  final String? title;
  const Home({Key? key, this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool dayAndNight = false;

  @override
  void initState() {
    super.initState();
    var tm = context.read<ThemeProvider>();
    dayAndNight = tm.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    var tm = context.read<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile: ${widget.title!}"),
        actions: actionsMenu(context),
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
                Nav.to(context, '/about');
              },
              child: const Text('Goto About Page'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dayAndNight = false;
                  tm.setThemeMode(dayAndNight);
                });
              },
              child: const Text("Day"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dayAndNight = true;
                  tm.setThemeMode(dayAndNight);
                });
              },
              child: const Text("Night"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
