import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/payment.dart';

class PaymentService {
  static const String boxName = 'payments';
  Box<Payment>? box;

  PaymentService() {
    init();
  }

  Future init() async {
    box = Hive.box<Payment>(boxName);
  }

  List<Payment> getAll() {
    List<Payment> payments = box!.values.toList();
    return payments;
  }

  Future<int> add(Payment payment) async {
    return await box!.add(payment);
  }

  Payment get(int index) {
    return box!.getAt(index)!;
  }

  Future<bool> update(Payment payment) async {
    int index = getAll().indexWhere(
      (element) => element.uid == payment.uid,
    );
    return await updateByIndex(index, payment);
  }

  Future<bool> updateByIndex(int index, Payment payment) async {
    bool isSuccess = false;
    await box!
        .putAt(index, payment)
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
