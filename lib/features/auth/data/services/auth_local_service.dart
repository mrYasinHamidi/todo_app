import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/app_user.dart';

class AuthLocalService {
  late final Box _box;

  Future<void> ensureInitialize() async {
    _box = await Hive.openBox('authBox');
  }

  Future<void> saveUser(AppUser user) async {
    await _box.put('current', user);
  }

  Future<AppUser?> getUser() async {
    return await _box.get('current');
  }

  Future<void> clear() => _box.clear();
}
