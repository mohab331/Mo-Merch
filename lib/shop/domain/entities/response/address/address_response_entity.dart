/// Represents an address response entity.
class AddressResponseEntity {
  const AddressResponseEntity({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
  })  : latitude = 0.0,
        longitude = 0.0;

  final int id;
  final String name;
  final String city;
  final String region;
  final String details;
  final double latitude;
  final double longitude;
  final String notes;
}
