import 'package:hive/hive.dart';

import '../../../hive_helper/fields/business_fields.dart';
import '../../../hive_helper/hive_adapters.dart';
import '../../../hive_helper/hive_types.dart';

part 'business.g.dart';

@HiveType(typeId: HiveTypes.business, adapterName: HiveAdapters.business)
class Business extends HiveObject {
  @HiveField(BusinessFields.id)
  String? id;
  @HiveField(BusinessFields.uid)
  String? uid;
  @HiveField(BusinessFields.name)
  String? name;
  @HiveField(BusinessFields.address)
  String? address;
  @HiveField(BusinessFields.city)
  String? city;
  @HiveField(BusinessFields.state)
  String? state;
  @HiveField(BusinessFields.country)
  String? country;
  @HiveField(BusinessFields.pincode)
  int? pincode;
  @HiveField(BusinessFields.email)
  String? email;
  @HiveField(BusinessFields.website)
  String? website;
  @HiveField(BusinessFields.phone)
  String? phone;
  @HiveField(BusinessFields.altPhone)
  String? altPhone;

  @override
  String toString() {
    return 'Business(id: $id, uid: $uid, name: $name, address: $address, city: $city, state: $state, country: $country, pincode: $pincode, email: $email, website: $website, phone: $phone, altPhone: $altPhone)';
  }
}
