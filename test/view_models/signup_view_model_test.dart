import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/features/auth/view/viewModels/signup/signup_view_model.dart';
import 'package:todo_app/features/common/models/app_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late SignupViewModel signupViewModel;

  final fakeUser = AppUser(uid: '123', email: 'test@example.com');

  setUp(() {
    mockRepository = MockAuthRepository();
    signupViewModel = SignupViewModel(authRepository: mockRepository);
  });

  blocTest<SignupViewModel, SignupState>(
    'emits [SignupLoadingState, SignupSuccessState] when signIn returns AppUser',
    build: () {
      when(() => mockRepository.signup(any(), any())).thenAnswer((_) async => Right(fakeUser));
      return signupViewModel;
    },
    act: (cubit) => cubit.signup('test@example.com', 'password'),
    expect:
        () => [
          isA<SignupLoadingState>(),
          isA<SignupSuccessState>().having((s) => s.appUser.email, 'email', 'test@example.com'),
        ],
  );

  blocTest<SignupViewModel, SignupState>(
    'emits [SignupLoadingState, SignupFailState] when signIn returns Failure',
    build: () {
      when(() => mockRepository.signup(any(), any())).thenAnswer((_) async => Left(Failure('Invalid credentials')));
      return signupViewModel;
    },
    act: (cubit) => cubit.signup('test@example.com', 'wrongpassword'),
    expect:
        () => [
          isA<SignupLoadingState>(),
          isA<SignupFailState>().having((s) => s.errorMessage, 'errorMessage', 'Invalid credentials'),
        ],
  );

  test('initial state is SignupInitialStateState', () {
    expect(signupViewModel.state, isA<SignupInitialState>());
  });
}
