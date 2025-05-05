import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/app_translate.dart';

import '../error/error.dart';

abstract class BaseRepository {
  const BaseRepository();

  Future<Either<Failure, T>> perform<T>(Future<T> Function() func) async {
    try {
      return Right(await func());
    } catch (e, s) {
      return Left(_handleError(e, s));
    }
  }

  Either<Failure, T> performSync<T>(T Function() func) {
    try {
      return Right(func());
    } catch (e, s) {
      return Left(_handleError(e, s));
    }
  }

  Failure _handleError(e, s) {
    String? message;
    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        message = AppTranslate.userNotFoundError;
      } else if (e.code == 'wrong-password') {
        message = AppTranslate.wrongPasswordError;
      } else if (e.code == 'weak-password') {
        message = AppTranslate.weakPasswordError;
      } else if (e.code == 'email-already-in-use') {
        message = AppTranslate.emailAlreadyUsedError;
      }
    }
    return Failure(message ?? AppTranslate.serverError);
  }
}
