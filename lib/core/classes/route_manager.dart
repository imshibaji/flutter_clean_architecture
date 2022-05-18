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

class Nav {
  static void toNamed(
    BuildContext context,
    String url, {
    Object? arguments,
  }) =>
      Navigator.pushNamed(
        context,
        url,
        arguments: arguments,
      );

  static void to(
    BuildContext context,
    String url, {
    Object? arguments,
    Object? result,
  }) {
    Navigator.pushReplacementNamed(
      context,
      url,
      result: result,
      arguments: arguments,
    );
  }

  static void close(BuildContext context, [Object? result]) {
    Navigator.pop(context, result);
  }
}
