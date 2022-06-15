import 'dart:developer';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    if (Platform.isAndroid &&
        await Permission.manageExternalStorage.isGranted) {
      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // String appPath = appDocDir.path;
      String appPath = '/storage/emulated/0/LeadsBook/data';
      Directory(appPath).create(recursive: true);

      // Copy Previous Databases
      // copyData();
      log(appPath);

      String dbLeads = appPath + '/' + LeadService.boxName + '.db';
      if (await File(dbLeads).exists() == false) {
        await Hive.openBox<Lead>(LeadService.boxName, path: dbLeads);
      }

      String dbDeals = appPath + '/' + DealService.boxName + '.db';
      if (await File(dbDeals).exists() == false) {
        await Hive.openBox<Deal>(DealService.boxName, path: dbDeals);
      }

      String dbFollowups = appPath + '/' + FollowupService.boxName + '.db';
      if (await File(dbFollowups).exists() == false) {
        await Hive.openBox<Followup>(FollowupService.boxName,
            path: dbFollowups);
      }

      String dbPayments = appPath + '/' + PaymentService.boxName + '.db';
      if (await File(dbPayments).exists() == false) {
        await Hive.openBox<Payment>(PaymentService.boxName, path: dbPayments);
      }

      String dbProfile = appPath + '/' + ProfileService.boxName + '.db';
      if (await File(dbProfile).exists() == false) {
        await Hive.openBox<Profile>(ProfileService.boxName, path: dbProfile);
      }

      String dbBusiness = appPath + '/' + BusinessService.boxName + '.db';
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

void copyData() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  if (await appDocDir.exists() == true) {
    String appPath = '/storage/emulated/0/LeadsBook/data';
    Directory copyPath = await Directory(appPath).create(recursive: true);
    if (await appDocDir.list().length > 0) {
      appDocDir.list(recursive: true).forEach((element) async {
        await element.rename(copyPath.path);
      });
    }
  }
}
