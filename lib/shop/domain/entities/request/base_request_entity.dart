/// Abstract class that serves as the base for request entities.
abstract class BaseRequestEntity {
  /// Converts the entity object to a JSON map representation.
  Map<String, dynamic> toJson();
}
