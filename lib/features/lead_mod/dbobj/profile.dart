import 'dart:convert';

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

  Profile({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.mobile,
    this.website,
    this.apiServerLink,
    this.authKey,
    this.imageLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'mobile': mobile,
      'website': website,
      'apiServerLink': apiServerLink,
      'authKey': authKey,
      'imageLink': imageLink,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      website: map['website'],
      apiServerLink: map['apiServerLink'],
      authKey: map['authKey'],
      imageLink: map['imageLink'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
