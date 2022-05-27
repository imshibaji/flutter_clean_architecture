import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../hive_helper/fields/payment_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

part 'payment.g.dart';

@HiveType(typeId: HiveTypes.payment, adapterName: HiveAdapters.payment)
class Payment extends HiveObject {
  @HiveField(PaymentFields.id)
  String? id;
  @HiveField(PaymentFields.uid)
  String? uid;
  @HiveField(PaymentFields.details)
  String? details;
  @HiveField(PaymentFields.amount)
  double? amount;
  @HiveField(PaymentFields.type)
  String? type; // Income / Expanse
  @HiveField(PaymentFields.createdAt)
  DateTime? createdAt;

  Payment({
    this.id,
    this.uid,
    this.details,
    this.amount,
    this.type,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'details': details,
      'amount': amount,
      'type': type,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      uid: map['uid'],
      details: map['details'],
      amount: map['amount']?.toDouble(),
      type: map['type'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));
}
