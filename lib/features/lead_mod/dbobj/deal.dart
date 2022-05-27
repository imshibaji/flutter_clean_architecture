import 'package:hive/hive.dart';
import 'package:clean_architecture/hive_helper/hive_types.dart';
import 'package:clean_architecture/hive_helper/hive_adapters.dart';
import 'package:clean_architecture/hive_helper/fields/deal_fields.dart';


part 'deal.g.dart';


@HiveType(typeId: HiveTypes.deal, adapterName: HiveAdapters.deal)
class Deal extends HiveObject{
	@HiveField(DealFields.name)
  late String name;
	@HiveField(DealFields.details)
  late String details;
	@HiveField(DealFields.price)
  late double price;
}