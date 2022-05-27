import 'dart:convert';

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
  @HiveField(DealFields.status)
  String? status; // Done / None
  @HiveField(DealFields.createdAt)
  DateTime? createdAt;

  Deal({
    this.id,
    this.uid,
    this.name,
    this.details,
    this.price,
    this.status,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'details': details,
      'price': price,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Deal.fromMap(Map<String, dynamic> map) {
    return Deal(
      id: map['id'],
      uid: map['uid'],
      name: map['name'],
      details: map['details'],
      price: map['price']?.toDouble(),
      status: map['status'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Deal.fromJson(String source) => Deal.fromMap(json.decode(source));
}
