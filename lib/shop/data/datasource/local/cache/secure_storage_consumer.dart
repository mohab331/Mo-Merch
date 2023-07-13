import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app_clean_architecture/core/error/exception.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/local/cache/base_secure_storage_consumer.dart';

/// A class that implements the `BaseAppLocalStorageConsumer` interface
/// and interacts with secure storage using `flutter_secure_storage`.
class SecureStorageConsumer implements BaseSecureStorageConsumer {
  /// Creates a new instance of `SecureStorageConsumer` with the provided `secureStorage`.
  const SecureStorageConsumer({
    required this.secureStorage,
  });

  /// The instance of `FlutterSecureStorage` used to interact with the secure storage.
  final FlutterSecureStorage secureStorage;

  /// Deletes the data associated with the given `key` from the secure storage.
  @override
  Future<void> clearUserData({
    required String key,
  }) async {
    await secureStorage.delete(key: key).onError(
          (error, stackTrace) => throw CacheException(
            errorMessage: error.toString(),
          ),
        );
  }

  /// Retrieves the data associated with the given `key` from the secure storage.
  @override
  Future<String?> getData({
    required String key,
  }) async {
    return  secureStorage.read(key: key).onError(
          (error, stackTrace) => throw CacheException(
            errorMessage: error.toString(),
          ),
        );
  }

  /// Stores the provided `data` in the secure storage under the given `key`.
  ///
  /// The `data` can be a `String`, `Map<String, dynamic>`, `double`, or `bool`.
  @override
  Future<void> setData({
    required String key,
    required data,
  }) async {
    {
      String value;
      if (data is String || data is double || data is bool) {
        value = data.toString();
      } else if (data is Map<String, dynamic>) {
        value = json.encode(data);
      } else {
        value = data.toString();
      }
      await secureStorage.write(key: key, value: value).onError(
            (error, stackTrace) => throw CacheException(
              errorMessage: error.toString(),
            ),
          );
    }
  }
}
