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

  Future<int> add(Deal deal) async {
    return await box!.add(deal);
  }

  Deal get(int index) {
    return box!.getAt(index)!;
  }

  Future<bool> update(Deal deal) async {
    int index = getAll().indexWhere(
      (element) => element.uid == deal.uid,
    );
    return await updateByIndex(index, deal);
  }

  Future<bool> updateByIndex(int index, Deal deal) async {
    bool isSuccess = false;
    await box!
        .putAt(index, deal)
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
