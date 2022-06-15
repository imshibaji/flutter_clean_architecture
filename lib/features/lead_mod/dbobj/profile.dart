import 'package:hive/hive.dart';

import '../../../hive_helper/fields/profile_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

part 'profile.g.dart';

@HiveType(typeId: HiveTypes.profile, adapterName: HiveAdapters.profile)
class Profile extends HiveObject {
  @HiveField(ProfileFields.id)
  String? id;
  @HiveField(ProfileFields.uid)
  String? uid;
  @HiveField(ProfileFields.name)
  String? name;
  @HiveField(ProfileFields.email)
  String? email;
  @HiveField(ProfileFields.password)
  String? password;
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

  @override
  String toString() {
    return 'Profile(id: $id, uid: $uid, name: $name, email: $email, mobile: $mobile, website: $website, apiServerLink: $apiServerLink, authKey: $authKey, imageLink: $imageLink)';
  }
}
