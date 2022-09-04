import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: appProviders,
    child: const CleanApp(),
  ));
}

class CleanApp extends StatelessWidget {
  const CleanApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tm = context.watch<ThemeProvider>();
    // print("My App: " + tm.isDarkMode.toString());

    return MaterialApp(
      title: 'Clean App',
      debugShowCheckedModeBanner: false,
      theme: MyTheme().lightTheme,
      darkTheme: MyTheme().darkTheme,
      themeMode: tm.themeMode,
      initialRoute: '/',
      routes: Routes().routes,
    );
  }
}
