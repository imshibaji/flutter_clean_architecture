import 'dart:developer';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../features/lead_mod/dbobj/dbobjs.dart';
import '../features/lead_mod/services/services.dart';

void registerAdapters() async {
  await Hive.initFlutter();

  Hive.registerAdapter(LeadAdapter());
  Hive.registerAdapter(FollowupAdapter());
  Hive.registerAdapter(DealAdapter());
  Hive.registerAdapter(PaymentAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(BusinessAdapter());

  SchedulerBinding.instance.addPostFrameCallback((_) async {
    if (Platform.isAndroid) {
      Directory? appDocDir = await getApplicationDocumentsDirectory();
      String appPath = appDocDir.path + '/data';
      Directory(appPath).create(recursive: true);

      log(appPath);

      String dbLeads = appPath + '/' + LeadService.boxName + '.db';
      copyData(File(dbLeads));

      if (await File(dbLeads).exists() == false) {
        await Hive.openBox<Lead>(LeadService.boxName, path: dbLeads);
      }

      String dbDeals = appPath + '/' + DealService.boxName + '.db';
      copyData(File(dbDeals));

      if (await File(dbDeals).exists() == false) {
        await Hive.openBox<Deal>(DealService.boxName, path: dbDeals);
      }

      String dbFollowups = appPath + '/' + FollowupService.boxName + '.db';
      copyData(File(dbFollowups));

      if (await File(dbFollowups).exists() == false) {
        await Hive.openBox<Followup>(FollowupService.boxName,
            path: dbFollowups);
      }

      String dbPayments = appPath + '/' + PaymentService.boxName + '.db';
      copyData(File(dbPayments));
      if (await File(dbPayments).exists() == false) {
        await Hive.openBox<Payment>(PaymentService.boxName, path: dbPayments);
      }

      String dbProfile = appPath + '/' + ProfileService.boxName + '.db';
      copyData(File(dbProfile));

      if (await File(dbProfile).exists() == false) {
        await Hive.openBox<Profile>(ProfileService.boxName, path: dbProfile);
      }

      String dbBusiness = appPath + '/' + BusinessService.boxName + '.db';
      copyData(File(dbBusiness));
      if (await File(dbBusiness).exists() == false) {
        await Hive.openBox<Business>(BusinessService.boxName, path: dbBusiness);
      }
    }

    // await Hive.openBox<Lead>(LeadService.boxName);
    // await Hive.openBox<Deal>(DealService.boxName);
    // await Hive.openBox<Followup>(FollowupService.boxName);
    // await Hive.openBox<Payment>(PaymentService.boxName);
    // await Hive.openBox<Profile>(ProfileService.boxName);
  });
}

void copyData(File file) async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // print(appDir.listSync());

  if (await file.exists() == true) {
    String appPath = appDir.path + '/data';
    Directory copyPath = await Directory(appPath).create(recursive: true);
    file.rename(copyPath.path + '/' + file.absolute.path);
    // print(file.path);
  }
}
