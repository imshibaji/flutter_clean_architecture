import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../hive_helper/fields/lead_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';
import 'dbobjs.dart';

part 'lead.g.dart';

@HiveType(typeId: HiveTypes.lead, adapterName: HiveAdapters.lead)
class Lead extends HiveObject {
  @HiveField(LeadFields.id)
  String? id;
  @HiveField(LeadFields.uid)
  String? uid;
  @HiveField(LeadFields.purpose)
  String? purpose;
  @HiveField(LeadFields.name)
  String? name;
  @HiveField(LeadFields.email)
  String? email;
  @HiveField(LeadFields.mobile)
  String? mobile;
  @HiveField(LeadFields.source)
  String? source;
  @HiveField(LeadFields.status)
  String? status;
  @HiveField(LeadFields.followups)
  List<Followup>? followups;
  @HiveField(LeadFields.deals)
  List<Deal>? deals;
  @HiveField(LeadFields.payments)
  List<Payment>? payments;

  Lead({
    this.id,
    this.uid,
    this.purpose,
    this.name,
    this.email,
    this.mobile,
    this.source,
    this.status,
    this.followups,
    this.deals,
    this.payments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'purpose': purpose,
      'name': name,
      'email': email,
      'mobile': mobile,
      'source': source,
      'status': status,
      'followups': followups?.map((x) => x.toMap()).toList(),
      'deals': deals?.map((x) => x.toMap()).toList(),
      'payments': payments?.map((x) => x.toMap()).toList(),
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      id: map['id'],
      uid: map['uid'],
      purpose: map['purpose'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      source: map['source'],
      status: map['status'],
      followups: map['followups'] != null
          ? List<Followup>.from(
              map['followups']?.map((x) => Followup.fromMap(x)))
          : null,
      deals: map['deals'] != null
          ? List<Deal>.from(map['deals']?.map((x) => Deal.fromMap(x)))
          : null,
      payments: map['payments'] != null
          ? List<Payment>.from(map['payments']?.map((x) => Payment.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lead.fromJson(String source) => Lead.fromMap(json.decode(source));
}
