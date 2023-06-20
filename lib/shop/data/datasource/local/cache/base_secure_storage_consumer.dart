/// An abstract class that defines the contract for interacting with the application's local storage.
abstract class BaseSecureStorageConsumer {
  /// Clears user data stored in the local storage associated with the specified [key].
  ///
  /// Returns a [Future] that completes once the user data has been cleared.
  Future<void> clearUserData({
    required String key,
  });

  /// Retrieves data stored in the local storage associated with the specified [key].
  ///
  /// Returns the retrieved data, or `null` if no data is found for the given key.
  Future<String?> getData({
    required String key,
  });

  /// Stores the provided [data] in the local storage associated with the specified [key].

  Future<void> setData({
    required String key,
    required dynamic data,
  });
}
