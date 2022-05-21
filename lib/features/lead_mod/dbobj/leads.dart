import 'package:hive/hive.dart';

import '../../../hive_helper/fields/lead_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

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
  Map<String, dynamic>? status;

  Lead({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.status,
  });
}

@HiveType(typeId: 2)
class Status {}
