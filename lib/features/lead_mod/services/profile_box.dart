import 'package:hive_flutter/hive_flutter.dart';

import '../dbobj/dbobjs.dart';

class ProfileService {
  static const String boxName = 'profile';
  Box<Profile>? box;

  ProfileService() {
    init();
  }

  Future init() async {
    box = Hive.box<Profile>(boxName);
  }

  List<Profile> getAll() {
    List<Profile> profiles = box!.values.toList();
    return profiles;
  }

  Future<int> add(Profile profile) async {
    return await box!.add(profile);
  }

  Profile get(int index) {
    return box!.getAt(index)!;
  }

  Future<bool> update(Profile profile) async {
    int index = getAll().indexWhere(
      (element) => element.uid == profile.uid,
    );
    return await updateByIndex(index, profile);
  }

  Future<bool> updateByIndex(int index, Profile profile) async {
    bool isSuccess = false;
    await box!
        .putAt(index, profile)
        .onError((error, stackTrace) => error)
        .whenComplete(() => isSuccess = true);

    return isSuccess;
  }

  Future<bool> delete(int index) async {
    bool isSuccess = false;
    await box!
        .deleteAt(index)
        .onError((error, stackTrace) => error)
        .whenComplete(() => isSuccess = true);

    return isSuccess;
  }
}
