import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/models/app_user.dart';

class AuthMapper {
  final AuthRepository _repository;

  AuthMapper({required AuthRepository repository}) : _repository = repository;

  Either<Failure, AppUser?> getUser() => _repository.getUser();
}
