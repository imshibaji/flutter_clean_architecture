import 'package:flutter/material.dart';

class RouteManager {
  final Map<String, WidgetBuilder> _routes = {};
  void addRoute(String name, WidgetBuilder builder) {
    _routes.addAll({name: builder});
  }

  void addAll(Map<String, WidgetBuilder> routes) {
    _routes.addAll(routes);
  }

  Map<String, WidgetBuilder> get routes => _routes;

  Map<String, WidgetBuilder> get links => _routes;
}

class Nav extends Navigator {
  const Nav({Key? key}) : super(key: key);

  static void to(BuildContext context, String url) {
    Navigator.pushReplacementNamed(context, url);
  }
}
