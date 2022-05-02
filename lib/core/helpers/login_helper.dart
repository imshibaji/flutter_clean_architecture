import 'package:clean_archetructure/config/app_cache.dart';
import 'package:clean_archetructure/core/classes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void doAuth(BuildContext context, String username, String password) async {
  AppCache ac = AppCache();
  ac.doLogin(username, password);
  if (await ac.isLogin()) {
    print('authentickets done');
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Nav.to(context, '/');
    });
  }
}

void doLogout(BuildContext context) async {
  AppCache ac = AppCache();
  ac.doLogout();
  checkLogin(context);
}

void checkLogin(BuildContext context) {
  AppCache ac = AppCache();
  ac.isLogin().then((value) {
    print('check $value');

    if (value == false) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Nav.to(context, '/login');
      });
    }
  });
}
