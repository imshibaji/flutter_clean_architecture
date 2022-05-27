import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/lead.dart';

class LeadService {
  static const String boxName = 'leads';
  Box<Lead>? box;

  LeadService() {
    init();
  }

  Future init() async {
    box = Hive.box<Lead>(boxName);
  }

  List<Lead> getAll() {
    List<Lead> leads = box!.values.toList();
    return leads;
  }

  add(Lead lead) async {
    bool isSuccess = false;
    await box!.add(lead).whenComplete(() => isSuccess = true);
    return isSuccess;
  }

  get(int index) {
    return box!.getAt(index);
  }

  update(int index, Lead lead) async {
    bool isSuccess = false;
    await box!
        .putAt(index, lead)
        .onError((error, stackTrace) => error)
        .whenComplete(() => isSuccess = true);

    return isSuccess;
  }

  delete(int index) async {
    bool isSuccess = false;
    await box!
        .deleteAt(index)
        .onError((error, stackTrace) => error)
        .whenComplete(() => isSuccess = true);

    return isSuccess;
  }
}
