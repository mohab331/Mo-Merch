/// Abstract class that serves as the base for request entities.
abstract class BaseRequestModel {
  /// Converts the model object to a JSON map representation.
  Map<String, dynamic> toJson();
}
