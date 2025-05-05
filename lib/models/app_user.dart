
import 'package:hive_flutter/adapters.dart';

part 'app_user.g.dart';

@HiveType(typeId: 1)
class AppUser extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String email;

  AppUser({required this.uid, required this.email});
}