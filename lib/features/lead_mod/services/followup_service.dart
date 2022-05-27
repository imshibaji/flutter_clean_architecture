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

  add(Followup followup) async {
    bool isSuccess = false;
    await box!.add(followup).whenComplete(() => isSuccess = true);
    return isSuccess;
  }

  get(int index) {
    return box!.getAt(index);
  }

  update(int index, Followup followup) async {
    bool isSuccess = false;
    await box!
        .putAt(index, followup)
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
