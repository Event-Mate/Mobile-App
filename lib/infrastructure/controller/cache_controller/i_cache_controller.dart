import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';

abstract class ICacheController {
  Future<void> clear();
  Future<void> delete({required CacheKey key});

  Future<void> writeBool({required CacheKey key, required bool value});
  bool? readBool({required CacheKey key});

  Future<void> writeInt({required CacheKey key, required int value});
  int? readInt({required CacheKey key});

  Future<bool> writeString({required CacheKey key, required String value});
  String? readString({required CacheKey key});
}
