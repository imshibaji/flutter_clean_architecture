import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/dbobjs.dart';

class BusinessService {
  static const String boxName = 'business';
  Box<Business>? box;

  BusinessService() {
    init();
  }

  Future init() async {
    box = Hive.box<Business>(boxName);
  }

  List<Business> getAll() {
    List<Business> businesses = box!.values.toList();
    return businesses;
  }

  Future<int> add(Business business) async {
    return await box!.add(business);
  }

  Business get(int index) {
    return box!.getAt(index)!;
  }

  Future<bool> update(Business business) async {
    int index = getAll().indexWhere(
      (element) => element.uid == business.uid,
    );
    return await updateByIndex(index, business);
  }

  Future<bool> updateByIndex(int index, Business business) async {
    bool isSuccess = false;
    await box!
        .putAt(index, business)
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
