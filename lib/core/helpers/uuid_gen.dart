import 'package:uuid/uuid.dart';

String uuid() {
  var uuid = const Uuid();
  return uuid.v4();
}
