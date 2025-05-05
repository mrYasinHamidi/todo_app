import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/features/auth/view/viewModels/splash/splash_view_model.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late SplashViewModel splashViewModel;

  setUp(() {
    mockRepository = MockAuthRepository();
    splashViewModel = SplashViewModel(repository: mockRepository);
  });

  blocTest<SplashViewModel, SplashState>(
    'emits [UserSignedState] when isLoggedIn returns Right(true)',
    build: () {
      when(() => mockRepository.isLoggedIn()).thenAnswer((_) async => Right(true));
      return splashViewModel;
    },
    act: (cubit) => cubit.checkLoginStatus(),
    expect: () => [isA<UserSignedState>()],
  );

  blocTest<SplashViewModel, SplashState>(
    'emits [UserUnSignedState] when isLoggedIn returns Right(false)',
    build: () {
      when(() => mockRepository.isLoggedIn()).thenAnswer((_) async => Right(false));
      return splashViewModel;
    },
    act: (cubit) => cubit.checkLoginStatus(),
    expect: () => [isA<UserUnSignedState>()],
  );

  blocTest<SplashViewModel, SplashState>(
    'emits [SplashErrorState] when isLoggedIn returns Left(Failure)',
    build: () {
      when(() => mockRepository.isLoggedIn()).thenAnswer((_) async => Left(Failure('Unauthorized')));
      return splashViewModel;
    },
    act: (cubit) => cubit.checkLoginStatus(),
    expect: () => [isA<SplashErrorState>().having((s) => s.errorMessage, 'errorMessage', 'Unauthorized')],
  );
}
