import 'package:hive/hive.dart';
import 'package:clean_architecture/hive_helper/hive_types.dart';
import 'package:clean_architecture/hive_helper/hive_adapters.dart';
import 'package:clean_architecture/hive_helper/fields/profile_fields.dart';


part 'profile.g.dart';


@HiveType(typeId: HiveTypes.profile, adapterName: HiveAdapters.profile)
class Profile extends HiveObject{
	@HiveField(ProfileFields.id)
  String? id;
	@HiveField(ProfileFields.uid)
  String? uid;
	@HiveField(ProfileFields.name)
  String? name;
	@HiveField(ProfileFields.email)
  String? email;
	@HiveField(ProfileFields.mobile)
  String? mobile;
	@HiveField(ProfileFields.website)
  String? website;
	@HiveField(ProfileFields.apiServerLink)
  String? apiServerLink;
	@HiveField(ProfileFields.authKey)
  String? authKey;
	@HiveField(ProfileFields.imageLink)
  String? imageLink;
}