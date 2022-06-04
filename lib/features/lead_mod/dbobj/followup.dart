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
  @HiveField(FollowupFields.leadUid)
  String? leadUid;
  @HiveField(FollowupFields.isDone)
  bool? isDone = false;

  @override
  String toString() {
    return 'Followup(id: $id, uid: $uid, discuss: $discuss, status: $status, schedule: $schedule, leadUid: $leadUid, isDone: $isDone)';
  }
}
