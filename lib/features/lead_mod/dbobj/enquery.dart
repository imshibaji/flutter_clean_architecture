import 'package:hive/hive.dart';

part 'enquery.g.dart';

@HiveType(typeId: 1)
class Enquery extends HiveObject {
  @HiveField(0)
  String? id;
  // Hive fields go here
  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? mobile;

  @HiveField(4)
  String? status;

  @HiveField(5)
  List<Follow>? follows;
}

@HiveType(typeId: 2)
class Follow {
  @HiveField(0)
  String? details;

  @HiveField(1)
  String? status;
}
