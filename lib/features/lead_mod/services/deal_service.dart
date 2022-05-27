import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/deal.dart';

class DealService {
  static const String boxName = 'deals';
  Box<Deal>? box;

  DealService() {
    init();
  }

  Future init() async {
    box = Hive.box<Deal>(boxName);
  }

  List<Deal> getAll() {
    List<Deal> deals = box!.values.toList();
    return deals;
  }

  add(Deal deal) async {
    bool isSuccess = false;
    await box!.add(deal).whenComplete(() => isSuccess = true);
    return isSuccess;
  }

  get(int index) {
    return box!.getAt(index);
  }

  update(int index, Deal deal) async {
    bool isSuccess = false;
    await box!
        .putAt(index, deal)
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
