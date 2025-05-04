import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/app_user.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  static Future<User?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _saveUserToHive(result.user);
    return result.user;
  }

  static Future<User?> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    _saveUserToHive(result.user);
    return result.user;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    var box = Hive.box<AppUser>('users');
    box.clear();
  }

  static void _saveUserToHive(User? firebaseUser) {
    if (firebaseUser != null) {
      final box = Hive.box<AppUser>('users');
      final user = AppUser(uid: firebaseUser.uid, email: firebaseUser.email ?? '');
      box.put('current_user', user);
    }
  }

  static AppUser? getLocalUser() {
    final box = Hive.box<AppUser>('users');
    return box.get('current_user');
  }
}