import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pf_consumer_app/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageProvider = Provider<SharedPreferenceService>((ref) {
  return SharedPreferenceService(ref.read(sharedPreferenceProvider));
});

class SharedPreferenceService {
  final SharedPreferences _preferences;
  SharedPreferenceService(this._preferences);
  static const _tokenKey = 'auth_token';
  Future<void> saveToDisk<T>(String key, T content) async {
    Logger().d('(TRACE ✔✔✔✔✔) LocalStorageService: _saveToDisk. key: $key');

    if (content is String) {
      await _preferences.setString(key, content);
    }
    if (content is bool) {
      await _preferences.setBool(key, content);
    }
    if (content is int) {
      await _preferences.setInt(key, content);
    }
    if (content is double) {
      await _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences.setStringList(key, content);
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  T? getFromDisk<T>(String key) {
    var value = _preferences.get(key);
    // Logger().d('(TRACE  ✔✔✔✔✔) LocalStorageService:_getFromDisk. key: $key ');
    return value as T?;
  }

  Future<bool> deleteFromDisk(String key) async {
    // Logger()
    //     .d('(TRACE  ✔✔✔✔✔) LocalStorageService:  deleteFromDisk . key: $key ');
    return _preferences.remove(key);
  }

  Future<bool> clearAll() {
    return _preferences.clear();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
