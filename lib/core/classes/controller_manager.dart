import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../core.dart';

// ignore: must_be_immutable
abstract class StatelessController extends StatelessWidget {
  const StatelessController({Key? key}) : super(key: key);

  bool get auth => false;

  String get loginUrl => ApiEndpoint.appLoginUrl;

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

  String get loginUrl => ApiEndpoint.appLoginUrl;

  Display view(BuildContext context);

  @override
  Widget build(BuildContext context) {
    checkLogin(context, auth: auth, loginUrl: loginUrl);
    return view(context);
  }
}
