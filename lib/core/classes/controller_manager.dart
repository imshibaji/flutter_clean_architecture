import 'package:clean_archetructure/config/app_config.dart';
import 'package:flutter/material.dart';

import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:clean_archetructure/core/helpers/login_helper.dart';

// ignore: must_be_immutable
abstract class StatelessController extends StatelessWidget {
  const StatelessController({Key? key}) : super(key: key);

  bool get auth => false;

  String get loginUrl => Config.loginUrl;

  Display view(BuildContext context);

  @override
  Widget build(BuildContext context) {
    checkLogin(context, auth: auth, loginUrl: loginUrl);
    return view(context);
  }
}

// ignore: must_be_immutable
abstract class StatefulController extends StatefulWidget {
  const StatefulController({Key? key}) : super(key: key);
}

abstract class ControllerState<T extends StatefulController> extends State<T> {
  bool get auth => false;

  String get loginUrl => Config.loginUrl;

  Display view(BuildContext context);

  @override
  Widget build(BuildContext context) {
    checkLogin(context, auth: auth, loginUrl: loginUrl);
    return view(context);
  }
}
