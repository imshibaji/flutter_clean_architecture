import 'package:hive/hive.dart';
import 'package:clean_architecture/features/lead_mod/dbobj/followup.dart';
import 'package:clean_architecture/features/lead_mod/dbobj/deal.dart';
import 'package:clean_architecture/features/lead_mod/dbobj/leads.dart';

void registerAdapters() {
  Hive.registerAdapter(FollowupAdapter());
  Hive.registerAdapter(DealAdapter());
	Hive.registerAdapter(LeadAdapter());
}
