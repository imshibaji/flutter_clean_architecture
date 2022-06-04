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

  Future<int> add(Lead lead) async {
    return await box!.add(lead);
  }

  Lead get(int index) {
    return box!.getAt(index)!;
  }

  Future<bool> update(Lead lead) async {
    int index = getAll().indexWhere(
      (element) => element.uid == lead.uid,
    );
    return await updateByIndex(index, lead);
  }

  Future<bool> updateByIndex(int index, Lead lead) async {
    bool isSuccess = false;
    await box!.putAt(index, lead).whenComplete(() => isSuccess = true);

    return isSuccess;
  }

  Future<bool> delete(int index) async {
    bool isSuccess = false;
    await box!
        .deleteAt(index)
        .onError((error, stackTrace) => error)
        .whenComplete(() => isSuccess = true);

    return isSuccess;
  }
}
