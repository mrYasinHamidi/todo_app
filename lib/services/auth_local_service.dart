import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/app_user.dart';

class AuthLocalService {
  late final Box<AppUser> _box;

  Future<void> initialize() async {
    _box = await Hive.openBox('authBox');
  }

  void saveUser(AppUser user) {}
}
