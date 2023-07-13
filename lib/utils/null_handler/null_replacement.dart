/// A generic class that represents a replacement value for null values.
class NullReplacement<T> {
  /// Constructs a [NullReplacement] with the specified [value].
  const NullReplacement(this.value);
  final T value;

  /// Replaces the [originalValue] with the [value] if the [originalValue] is null.
  ///
  /// Returns the [originalValue] if it is not null, otherwise returns the [value].
  T replaceIfNull(T? originalValue) {
    return originalValue ?? value;
  }
}

/// A utility class that provides default replacements for different types.
class NullReplacements {
  /// Represents a replacement for null integer values.
  static NullReplacement<int> intReplacement = const NullReplacement<int>(-1);

  /// Represents a replacement for null string values.
  static NullReplacement<String> stringReplacement =
      const NullReplacement<String>('');

  /// Represents a replacement for null double values.
  static NullReplacement<double> doubleReplacement =
      const NullReplacement<double>(0.0);

  /// Returns a [NullReplacement] for null lists of type [T].
  ///
  /// The replacement value is an empty list.
  static NullReplacement<List<T>> listReplacement<T>() {
    return NullReplacement<List<T>>([]);
  }
}
