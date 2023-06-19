/// An abstract class representing a JSON converter.
///
/// Implementations of this class are responsible for converting JSON data
/// represented as a [Map] into an object of type [T].
abstract class JsonConverter<T> {

  /// Converts a [jsonMap] into an object of type [T].
  ///
  /// The [jsonMap] is a [Map] containing JSON data to be converted.
  ///
  /// Returns an object of type [T] created from the JSON data,
  /// or null if the [jsonMap] is null or invalid.
  T fromJson(Map<String, dynamic>? jsonMap);
}
