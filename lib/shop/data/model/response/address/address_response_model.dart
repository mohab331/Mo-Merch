import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class AddressResponseModel implements JsonConverter<AddressResponseModel> {
  const AddressResponseModel({
    this.id,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
    this.latitude,
    this.longitude,
  });

  final int? id;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final double? latitude;
  final double? longitude;
  final String? notes;

  @override
  AddressResponseModel fromJson(
    Map<String, dynamic>? jsonMap,
  ) {
    return AddressResponseModel(
      id: jsonMap?['id'],
      name: jsonMap?['name'],
      city: jsonMap?['city'],
      region: jsonMap?['region'],
      details: jsonMap?['details'],
      notes: jsonMap?['notes'],
      latitude: (jsonMap?['latitude'] as num?)?.toDouble(),
      longitude: (jsonMap?['longitude'] as num?)?.toDouble(),
    );
  }
}
