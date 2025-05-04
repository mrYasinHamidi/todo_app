import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/core/repository/repository.dart';
import 'package:todo_app/services/auth_remote_service.dart' show AuthRemoteService;

class AuthRepository extends Repository {
  final AuthRemoteService _remoteService;
  final AuthRemoteService _localService;

  AuthRepository({required AuthRemoteService remoteService, required AuthRemoteService localService})
    : _remoteService = remoteService,
      _localService = localService;

  Future<Either<Failure, bool>> isLoggedIn() => perform(() => _remoteService.isLoggedIn());
}
