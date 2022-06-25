import 'package:clean_architecture/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';
import 'features/awasome_notification/awasome_notification_service.dart';
import 'features/lead_mod/providers/firebase_tracker.dart';
// import 'core/core.dart';
import 'hive_helper/register_adapters.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwasomeNotificationService().initAwasomeNotification();
  AwasomeNotificationService().listenActionStream();

  Provider.debugCheckInvalidValueType = null;

  registerAdapters();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await FirebaseTracker().init();

    runApp(MultiProvider(
      providers: appProviders,
      child: const CleanApp(
          // lightTheme: await getLightTheme(),
          // darkTheme: await getDarkTheme(),
          ),
    ));
  });
}

class CleanApp extends StatelessWidget {
  final ThemeData? lightTheme, darkTheme;
  const CleanApp({Key? key, this.lightTheme, this.darkTheme}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tm = context.watch<ThemeProvider>();
    // print("My App: " + tm.isDarkMode.toString());

    return MaterialApp(
      title: 'Lead Book',
      debugShowCheckedModeBanner: false,
      theme: lightTheme ?? MyTheme().lightTheme,
      darkTheme: darkTheme ?? MyTheme().darkTheme,
      themeMode: tm.themeMode,
      initialRoute: 'splash/',
      routes: Routes().routes,
      navigatorKey: Nav.navigatorKey,
    );
  }
}
