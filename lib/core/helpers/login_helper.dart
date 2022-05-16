import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../config/config.dart';
import '../core.dart';

void doAuth(BuildContext context, String username, String password) async {
  AppCache ac = AppCache();
  ac.doLogin(username, password);
  if (await ac.isLogin()) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Nav.to(context, '/');
      showMessage(context, 'Login Successful');
    });
  }
}

Future<Map<String, String>> authData() async {
  AppCache ac = AppCache();
  return ac.auth();
}

void doLogout(BuildContext context) async {
  AppCache ac = AppCache();
  ac.doLogout();
  checkLogin(context, auth: true);
  showMessage(context, 'Logout Successfull');
}

void checkLogin(
  BuildContext context, {
  bool? auth = false,
  String? loginUrl = ApiEndpoint.appLoginUrl,
}) {
  AppCache ac = AppCache();
  ac.isLogin().then((value) {
    if (value == false && auth! == true) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Nav.to(context, loginUrl!);
      });
    }
  });
}
