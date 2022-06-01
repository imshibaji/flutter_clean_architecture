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
  HiveList<Followup>? followups;
  @HiveField(LeadFields.deals)
  HiveList<Deal>? deals;
  @HiveField(LeadFields.payments)
  HiveList<Payment>? payments;
}
