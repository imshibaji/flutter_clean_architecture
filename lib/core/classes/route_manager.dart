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
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
  }) {
    Navigator.pushNamed(
      context,
      url,
      arguments: arguments,
    );
  }

  static void toReplace(
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

  static T? routeData<T>(BuildContext context) {
    return (ModalRoute.of(context)!.settings.arguments != null)
        ? ModalRoute.of(context)!.settings.arguments as T
        : null;
  }

  static void go(
    String url, {
    Object? arguments,
  }) {
    navigatorKey.currentState!.pushNamed(url, arguments: arguments);
  }

  static void goTo(
    String url, {
    Object? arguments,
    Object? result,
  }) {
    navigatorKey.currentState!.pushReplacementNamed(
      url,
      result: result,
      arguments: arguments,
    );
  }

  static void back([Object? result]) {
    navigatorKey.currentState!.pop(result);
  }
}
