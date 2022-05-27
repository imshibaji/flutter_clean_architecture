import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../hive_helper/fields/followup_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

part 'followup.g.dart';

@HiveType(typeId: HiveTypes.followup, adapterName: HiveAdapters.followup)
class Followup extends HiveObject {
  @HiveField(FollowupFields.id)
  String? id;
  @HiveField(FollowupFields.uid)
  String? uid;
  @HiveField(FollowupFields.discuss)
  String? discuss;
  @HiveField(FollowupFields.status)
  String? status;
  @HiveField(FollowupFields.schedule)
  DateTime? schedule;

  Followup({
    this.id,
    this.uid,
    this.discuss,
    this.status,
    this.schedule,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'discuss': discuss,
      'status': status,
      'schedule': schedule?.millisecondsSinceEpoch,
    };
  }

  factory Followup.fromMap(Map<String, dynamic> map) {
    return Followup(
      id: map['id'],
      uid: map['uid'],
      discuss: map['discuss'],
      status: map['status'],
      schedule: map['schedule'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['schedule'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Followup.fromJson(String source) =>
      Followup.fromMap(json.decode(source));
}
