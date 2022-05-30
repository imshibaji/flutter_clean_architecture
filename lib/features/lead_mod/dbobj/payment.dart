import 'package:hive/hive.dart';
import 'package:clean_architecture/hive_helper/hive_types.dart';
import 'package:clean_architecture/hive_helper/hive_adapters.dart';
import 'package:clean_architecture/hive_helper/fields/payment_fields.dart';

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
  String? type;
  @HiveField(PaymentFields.createdAt)
  DateTime? createdAt;
  @HiveField(PaymentFields.leadUid)
  String? leadUid;
}
