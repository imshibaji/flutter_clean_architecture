import 'package:hive/hive.dart';

import '../features/lead_mod/dbobj/leads.dart';

void registerAdapters() {
  Hive.registerAdapter(LeadAdapter());
}
