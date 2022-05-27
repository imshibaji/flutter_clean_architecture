import 'package:hive/hive.dart';

import '../../../hive_helper/fields/lead_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';
import 'deal.dart';
import 'followup.dart';

part 'leads.g.dart';

@HiveType(typeId: HiveTypes.lead, adapterName: HiveAdapters.lead)
class Lead extends HiveObject {
  @HiveField(LeadFields.id)
  int? id;
  @HiveField(LeadFields.name)
  String? name;
  @HiveField(LeadFields.email)
  String? email;
  @HiveField(LeadFields.mobile)
  String? mobile;
  @HiveField(LeadFields.status)
  String? status;
  @HiveField(LeadFields.followups)
  List<Followup>? followups;
  @HiveField(LeadFields.deals)
  List<Deal>? deals;

  Lead({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.status,
    this.followups,
    this.deals,
  });
}
