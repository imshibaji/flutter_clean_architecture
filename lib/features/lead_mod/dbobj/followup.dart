import 'package:hive/hive.dart';
import 'package:clean_architecture/hive_helper/hive_types.dart';
import 'package:clean_architecture/hive_helper/hive_adapters.dart';
import 'package:clean_architecture/hive_helper/fields/followup_fields.dart';


part 'followup.g.dart';


@HiveType(typeId: HiveTypes.followup, adapterName: HiveAdapters.followup)
class Followup extends HiveObject{
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
}