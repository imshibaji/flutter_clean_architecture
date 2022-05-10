import 'package:clean_archetructure/config/app_cache.dart';
import 'package:clean_archetructure/config/app_config.dart';
import 'package:clean_archetructure/core/classes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void doAuth(BuildContext context, String username, String password) async {
  AppCache ac = AppCache();
  ac.doLogin(username, password);
  if (await ac.isLogin()) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Nav.to(context, '/');
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
}

void checkLogin(
  BuildContext context, {
  bool? auth = false,
  String? loginUrl = Config.loginUrl,
}) {
  AppCache ac = AppCache();
  ac.isLogin().then((value) {
    if (value == false && auth! == true) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Nav.to(context, loginUrl!);
      });
    }
  });
}
