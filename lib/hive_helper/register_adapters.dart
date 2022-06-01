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
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String dbLeads = appDocDir.path + '/' + LeadService.boxName + '.db';
    await Hive.openBox<Lead>(LeadService.boxName, path: dbLeads);

    String dbDeals = appDocDir.path + '/' + DealService.boxName + '.db';
    await Hive.openBox<Deal>(DealService.boxName, path: dbDeals);

    String dbFollowups = appDocDir.path + '/' + FollowupService.boxName + '.db';
    await Hive.openBox<Followup>(FollowupService.boxName, path: dbFollowups);

    String dbPayments = appDocDir.path + '/' + PaymentService.boxName + '.db';
    await Hive.openBox<Payment>(PaymentService.boxName, path: dbPayments);

    String dbProfile = appDocDir.path + '/' + ProfileService.boxName + '.db';
    await Hive.openBox<Profile>(ProfileService.boxName, path: dbProfile);

    String dbBusiness = appDocDir.path + '/' + BusinessService.boxName + '.db';
    await Hive.openBox<Business>(BusinessService.boxName, path: dbBusiness);

    // await Hive.openBox<Lead>(LeadService.boxName);
    // await Hive.openBox<Deal>(DealService.boxName);
    // await Hive.openBox<Followup>(FollowupService.boxName);
    // await Hive.openBox<Payment>(PaymentService.boxName);
    // await Hive.openBox<Profile>(ProfileService.boxName);
  });
}
