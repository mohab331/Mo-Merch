
import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class AddAddressRequestModel implements BaseRequestModel {
  AddAddressRequestModel({
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String city;
  final String region;
  final String details;
  final String notes;
  final double latitude;
  final double longitude;

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      };
}
