import 'package:clean_archetructure/features/auth_mod/auth_app.dart';
import 'package:flutter/material.dart';

import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:clean_archetructure/core/helpers/login_helper.dart';

// ignore: must_be_immutable
abstract class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  bool get auth => false;

  String get loginUrl => AuthApp.login;

  Display view(BuildContext context);

  @override
  Widget build(BuildContext context) {
    checkLogin(context, auth: auth, loginUrl: loginUrl);
    return view(context);
  }
}
