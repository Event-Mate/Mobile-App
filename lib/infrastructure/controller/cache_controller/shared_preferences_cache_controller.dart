import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCacheController implements ICacheController {
  SharedPreferencesCacheController(this._sharedPref);
  final SharedPreferences _sharedPref;

  @override
  Future<void> clear() {
    return _sharedPref.clear();
  }

  @override
  Future<void> delete({required CacheKey key}) {
    return _sharedPref.remove(key.value);
  }

  @override
  bool? readBool({required CacheKey key}) {
    return _sharedPref.getBool(key.value);
  }

  @override
  Future<void> writeBool({required CacheKey key, required bool value}) {
    return _sharedPref.setBool(key.value, value);
  }

  @override
  int? readInt({required CacheKey key}) {
    return _sharedPref.getInt(key.value);
  }

  @override
  Future<void> writeInt({required CacheKey key, required int value}) {
    return _sharedPref.setInt(key.value, value);
  }

  @override
  String? readString({required CacheKey key}) {
    return _sharedPref.getString(key.value);
  }

  @override
  Future<bool> writeString({required CacheKey key, required String value}) {
    return _sharedPref.setString(key.value, value);
  }
}
