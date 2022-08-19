import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/core/cache/cache_consumer.dart';

class SharedPreferenceConsumer implements CacheConsumer {
  SharedPreferences sharedPreferences;
  SharedPreferenceConsumer({required this.sharedPreferences});
  @override
  Future<bool> clearUserData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  @override
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  @override
  Future<bool> setData({required String key, required data}) async {
    if (data is String) {
      return await sharedPreferences.setString(key, data);
    } else if (data is Map<String, dynamic>) {
      String jsonMap = json.encode(data);
      return await sharedPreferences.setString(key, jsonMap);
    } else if (data is double) {
      return await sharedPreferences.setDouble(key, data);
    } else if (data is bool) {
      return await sharedPreferences.setBool(key, data);
    } else {
      return await sharedPreferences.setInt(key, data);
    }
  }
}
