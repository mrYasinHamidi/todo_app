import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/app_user.dart';

class AuthLocalService {
  late final Box _box;
  bool _initialized = false;

  Future<void> ensureInitialize() async {
    if (_initialized) return;
    _box = await Hive.openBox('authBox');
    _initialized = true;
  }

  Future<void> saveUser(AppUser user) async {
    await _box.put('current', user);
  }

  AppUser? getUser() {
    return _box.get('current');
  }

  Future<void> clear() => _box.clear();
}
