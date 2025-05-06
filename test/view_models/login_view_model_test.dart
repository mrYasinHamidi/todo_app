import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/features/auth/view/viewModels/login/login_view_model.dart';
import 'package:todo_app/features/common/models/app_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late LoginViewModel loginViewModel;

  final fakeUser = AppUser(uid: '123', email: 'test@example.com');

  setUp(() {
    mockRepository = MockAuthRepository();
    loginViewModel = LoginViewModel(authRepository: mockRepository);
  });

  blocTest<LoginViewModel, LoginState>(
    'emits [LoginLoadingState, LoginSuccessState] when signIn returns AppUser',
    build: () {
      when(() => mockRepository.signIn(any(), any())).thenAnswer((_) async => Right(fakeUser));
      return loginViewModel;
    },
    act: (cubit) => cubit.signIn('test@example.com', 'password'),
    expect:
        () => [
          isA<LoginLoadingState>(),
          isA<LoginSuccessState>().having((s) => s.appUser.email, 'email', 'test@example.com'),
        ],
  );

  blocTest<LoginViewModel, LoginState>(
    'emits [LoginLoadingState, LoginFailState] when signIn returns Failure',
    build: () {
      when(() => mockRepository.signIn(any(), any())).thenAnswer((_) async => Left(Failure('Invalid credentials')));
      return loginViewModel;
    },
    act: (cubit) => cubit.signIn('test@example.com', 'wrongpassword'),
    expect:
        () => [
          isA<LoginLoadingState>(),
          isA<LoginFailState>().having((s) => s.errorMessage, 'errorMessage', 'Invalid credentials'),
        ],
  );

  test('initial state is LoginInitialStateState', () {
    expect(loginViewModel.state, isA<LoginInitialStateState>());
  });
}
