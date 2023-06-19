abstract class BaseAppLocalStorageConsumer {
  Future<void> clearUserData({
    required String key,
  });
  dynamic getData({
    required String key,
  });
  Future<bool> setData({
    required String key,
    required data,
  });
}
