import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';
import 'hive_helper/register_adapters.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  registerAdapters();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: appProviders,
      child: const CleanApp(),
    ));
  });
}

class CleanApp extends StatelessWidget {
  const CleanApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tm = context.watch<ThemeProvider>();
    // print("My App: " + tm.isDarkMode.toString());

    return MaterialApp(
      title: 'Lead Book',
      debugShowCheckedModeBanner: false,
      theme: MyTheme().lightTheme,
      darkTheme: MyTheme().darkTheme,
      themeMode: tm.themeMode,
      initialRoute: 'splash/',
      routes: Routes().routes,
    );
  }
}
