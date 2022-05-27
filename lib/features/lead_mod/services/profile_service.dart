import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/payment.dart';

class ProfileService {
  static const String boxName = 'profile';
  Box<Payment>? box;

  ProfileService() {
    init();
  }

  Future init() async {
    box = Hive.box<Payment>(boxName);
  }

  List<Payment> getAll() {
    List<Payment> payments = box!.values.toList();
    return payments;
  }

  add(Payment payment) async {
    bool isSuccess = false;
    await box!.add(payment).whenComplete(() => isSuccess = true);
    return isSuccess;
  }

  get(int index) {
    return box!.getAt(index);
  }

  update(int index, Payment payment) async {
    bool isSuccess = false;
    await box!
        .putAt(index, payment)
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
