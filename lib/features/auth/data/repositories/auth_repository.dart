import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/core/repository/base_repository.dart';
import 'package:todo_app/features/auth/data/services/auth_local_service.dart';
import 'package:todo_app/features/auth/data/services/auth_remote_service.dart';
import 'package:todo_app/features/common/models/app_user.dart';

class AuthRepository extends BaseRepository {
  final AuthLocalService _localService;
  final AuthRemoteService _remoteService;

  const AuthRepository({required AuthLocalService localService, required AuthRemoteService remoteService})
    : _localService = localService,
      _remoteService = remoteService;

  Either<Failure, bool> isLoggedIn() {
    return performSync(() {
      final localUser = _localService.getUser();
      return localUser != null;
    });
  }

  Either<Failure, AppUser?> getUser() {
    return performSync(() => _localService.getUser());
  }

  Future<Either<Failure, AppUser>> signIn(String email, String password) async {
    return perform(() async {
      final remoteUser = await _remoteService.signIn(email, password);
      final appUser = AppUser(uid: remoteUser!.uid, email: email);
      await _localService.saveUser(appUser);
      return appUser;
    });
  }

  Future<Either<Failure, AppUser>> signup(String email, String password) async {
    return perform(() async {
      final remoteUser = await _remoteService.signUp(email, password);
      final appUser = AppUser(uid: remoteUser!.uid, email: email);
      await _localService.saveUser(appUser);
      return appUser;
    });
  }

  Future<Either<Failure, void>> logout() {
    return perform(() async {
      await _remoteService.signOut();
      await _localService.clear();
    });
  }
}
