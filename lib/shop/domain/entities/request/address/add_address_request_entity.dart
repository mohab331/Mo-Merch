import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddAddressRequestEntity implements BaseRequestEntity {
  AddAddressRequestEntity({
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
    this.latitude = 0.0,
    this.longitude = 0.0,
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
        'latitude': 0.0,
        'longitude': 0.0,
      };
}
