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
      copyData(dbLeads);

      if (await File(dbLeads).exists() == false) {
        await Hive.openBox<Lead>(LeadService.boxName, path: dbLeads);
      }

      String dbDeals = appPath + '/' + DealService.boxName + '.db';
      copyData(dbDeals);
      await Hive.openBox<Deal>(DealService.boxName, path: dbDeals);

      String dbFollowups = appPath + '/' + FollowupService.boxName + '.db';
      copyData(dbFollowups);
      await Hive.openBox<Followup>(FollowupService.boxName, path: dbFollowups);

      String dbPayments = appPath + '/' + PaymentService.boxName + '.db';
      copyData(dbPayments);
      await Hive.openBox<Payment>(PaymentService.boxName, path: dbPayments);

      String dbProfile = appPath + '/' + ProfileService.boxName + '.db';
      copyData(dbProfile);
      await Hive.openBox<Profile>(ProfileService.boxName, path: dbProfile);

      String dbBusiness = appPath + '/' + BusinessService.boxName + '.db';
      copyData(dbBusiness);
      await Hive.openBox<Business>(BusinessService.boxName, path: dbBusiness);
    }

    // await Hive.openBox<Lead>(LeadService.boxName);
    // await Hive.openBox<Deal>(DealService.boxName);
    // await Hive.openBox<Followup>(FollowupService.boxName);
    // await Hive.openBox<Payment>(PaymentService.boxName);
    // await Hive.openBox<Profile>(ProfileService.boxName);
  });
}

Future<Directory?> copyData(String dbPath) async {
  Directory appDir = await getApplicationDocumentsDirectory();
  String oldAppDataPath = appDir.path;
  String newAppDataPath = appDir.path + '/data';

  Directory oldFile = Directory(oldAppDataPath + '/' + dbPath.split('/').last);
  // log(oldFile.path);
  // print(await oldFile.exists());
  if (await oldFile.exists()) {
    Directory copyPath =
        await Directory(newAppDataPath).create(recursive: true);
    Directory newFile =
        await oldFile.rename(copyPath.path + '/' + dbPath.split('/').last);
    // log(newFile.path);
    return newFile;
  }
  return null;
}
