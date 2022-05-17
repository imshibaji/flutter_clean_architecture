import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/core.dart';
import '../features/features.dart';
import '../features/main_app/providers/news_provider.dart';
import 'app_theme.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<ThemeProvider>(
    create: (context) => ThemeProvider(),
  ),
  ChangeNotifierProvider<GlobalStateManager>(
    create: (context) => GlobalStateManager(),
  ),
  ChangeNotifierProvider<NewsProvider>(
    create: (context) => NewsProvider(),
  ),
  ChangeNotifierProvider<EnqueryProvider>(
    create: (context) => EnqueryProvider(),
  )
];
