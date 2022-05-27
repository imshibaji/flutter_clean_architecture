import 'package:hive/hive.dart';

import '../../../hive_helper/fields/followup_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

part 'followup.g.dart';

@HiveType(typeId: HiveTypes.followup, adapterName: HiveAdapters.followup)
class Followup extends HiveObject {
  @HiveField(FollowupFields.discuss)
  late String discuss;
  @HiveField(FollowupFields.status)
  late String status;
}
