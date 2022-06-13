import 'package:hive/hive.dart';

import '../../../hive_helper/fields/deal_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

part 'deal.g.dart';

@HiveType(typeId: HiveTypes.deal, adapterName: HiveAdapters.deal)
class Deal extends HiveObject {
  @HiveField(DealFields.id)
  String? id;
  @HiveField(DealFields.uid)
  String? uid;
  @HiveField(DealFields.name)
  String? name;
  @HiveField(DealFields.details)
  String? details;
  @HiveField(DealFields.price)
  double? price;
  @HiveField(DealFields.discount)
  double? discount;
  @HiveField(DealFields.status)
  String? status;
  @HiveField(DealFields.createdAt)
  DateTime? createdAt;
  @HiveField(DealFields.leadUid)
  String? leadUid;

  @override
  String toString() {
    return 'Deal(id: $id, uid: $uid, name: $name, details: $details, price: $price, discount: $discount, status: $status, createdAt: $createdAt, leadUid: $leadUid)';
  }
}
