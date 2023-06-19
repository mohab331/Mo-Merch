import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/local/cache/base_local_storage_consumer.dart';

/// A class that implements the `BaseAppLocalStorageConsumer` interface
/// and interacts with secure storage using `flutter_secure_storage`.
class SecureStorageConsumer implements BaseAppLocalStorageConsumer {
  /// Creates a new instance of `SecureStorageConsumer` with the provided `secureStorage`.
  const SecureStorageConsumer({
    required this.secureStorage,
  });

  /// The instance of `FlutterSecureStorage` used to interact with the secure storage.
  final FlutterSecureStorage secureStorage;

  /// Deletes the data associated with the given `key` from the secure storage.
  @override
  Future<void> clearUserData({required String key}) async {
    await secureStorage.delete(key: key);
  }

  /// Retrieves the data associated with the given `key` from the secure storage.
  @override
  Future<String?> getData({required String key}) async {
    return await secureStorage.read(key: key);
  }

  /// Stores the provided `data` in the secure storage under the given `key`.
  ///
  /// The `data` can be a `String`, `Map<String, dynamic>`, `double`, or `bool`.
  @override
  Future<bool> setData({
    required String key,
    required data,
  }) async {
    if (data is String) {
      await secureStorage.write(key: key, value: data);
    } else if (data is Map<String, dynamic>) {
      String jsonMap = json.encode(data);
      await secureStorage.write(key: key, value: jsonMap);
    } else if (data is double) {
      await secureStorage.write(key: key, value: data.toString());
    } else if (data is bool) {
      await secureStorage.write(key: key, value: data.toString());
    } else {
      await secureStorage.write(key: key, value: data.toString());
    }
    return true;
  }
}
