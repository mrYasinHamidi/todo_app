import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/features/auth/auth_mapper.dart';
import 'package:todo_app/models/app_user.dart';

class TaskMapper {
  final AuthMapper _authMapper;

  TaskMapper({required AuthMapper authMapper}) : _authMapper = authMapper;

  Either<Failure, AppUser?> getUser() => _authMapper.getUser();
}
