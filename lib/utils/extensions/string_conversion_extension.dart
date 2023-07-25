import 'dart:convert';
import 'package:intl/intl.dart';


/// An extension on [String?] that provides methods to convert a string to various types.
extension StringConversionExtension on String? {
  /// Converts the string to a boolean value.
  ///
  /// Returns `true` if the string is case-insensitive equal to 'true', 'yes', or '1',
  /// otherwise returns `false`.
  ///
  /// Throws a [FormatException] if the string is not a valid boolean value.
  ///

  bool? toBool() {
    if (this == null) return null;
    return this?.toLowerCase() == 'true' ||
        this?.toLowerCase() == 'yes' ||
        this == '1';
  }

  /// Converts the string to an integer value.
  ///
  /// Throws a [FormatException] if the string is not a valid integer.
  ///
  int? toInt() {
    if (this == null) return null;
    return int.tryParse(this!);
  }

  /// Converts the string to a double value.
  ///
  /// Throws a [FormatException] if the string is not a valid double.
  ///
  double? toDouble() {
    if (this == null) return null;
    return double.tryParse(this!);
  }


  /// Converts a string to a [Map<String, dynamic>].
  ///
  /// Returns `null` if the string is `null` or unable to parse as a map.
  ///
  /// Throws a [FormatException] if the string is not a valid JSON format.
  ///

  Map<String, dynamic>? toMap() {
    if (this == null) {
      return null;
    }
    try {
      final dynamic parsedJson = json.decode(this!);
      if (parsedJson is Map<String, dynamic>) {
        return parsedJson;
      } else {
        return null;
      }
    } on FormatException catch (_) {
      return null;
    }
  }


}
