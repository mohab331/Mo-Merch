import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddAddressRequestEntity implements BaseRequestEntity {
  AddAddressRequestEntity({
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
  double latitude;
  double longitude;

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

  void setLatLng(LatLng value) {
    latitude = value.latitude;
    longitude = value.longitude;
  }
}
