import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/followup.dart';

class FollowupService {
  static const String boxName = 'followups';
  Box<Followup>? box;

  FollowupService() {
    init();
  }

  Future init() async {
    box = Hive.box<Followup>(boxName);
  }

  List<Followup> getAll() {
    List<Followup> followups = box!.values.toList();
    return followups;
  }

  Future<int> add(Followup followup) async {
    return await box!.add(followup);
  }

  Followup get(int index) {
    return box!.getAt(index)!;
  }

  Future<bool> update(Followup followup) async {
    int index = getAll().indexWhere(
      (element) => element.uid == followup.uid,
    );
    return await updateByIndex(index, followup);
  }

  Future<bool> updateByIndex(int index, Followup followup) async {
    bool isSuccess = false;
    await box!
        .putAt(index, followup)
        .onError((error, stackTrace) => error)
        .whenComplete(() => isSuccess = true);

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
