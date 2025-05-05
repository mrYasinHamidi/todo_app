mixin AppTranslate {
  static const String title = 'title';
  static const String thisIs = 'thisIs';
  static const String userNotFoundError = 'userNotFoundError';
  static const String wrongPasswordError = 'wrongPasswordError';
  static const String weakPasswordError = 'weakPasswordError';
  static const String emailAlreadyUsedError = 'emailAlreadyUsedError';
  static const String serverError = 'serverError';
  static const String email = 'email';
  static const String password = 'password';
  static const String passwordNotMatch = 'passwordNotMatch';
  static const String signUp = 'Signup';
  static const String signIn = 'SignIn';
  static const String signupSuggestion = 'signupSuggestion';
  static const String signinSuggestion = 'signinSuggestion';
  static const String emailFormatError = 'emailFormatError';
  static const String passwordConfirm = 'passwordConfirm';

  static const Map<String, dynamic> EN = {
    title: 'Localization',
    thisIs: 'This is %a package, version %a.',
    userNotFoundError: 'No user found for that email.',
    wrongPasswordError: 'Wrong password provided for that user.',
    weakPasswordError: 'The password provided is too weak.',
    emailAlreadyUsedError: 'The account already exists for that email.',
    serverError: 'The account already exists for that email.',
    email: 'Email',
    password: 'Password',
    signIn: 'Sign In',
    signUp: 'Sign Up',
    signupSuggestion: 'Or you can Sign Up , Click here',
    signinSuggestion: 'If you already hav an account click here',
    emailFormatError: 'Email format is incorrect.',
    passwordNotMatch: 'Password not match.',
    passwordConfirm: 'Confirm password',
  };
  static const Map<String, dynamic> FA = {
    title: 'ローカリゼーション',
    thisIs: 'これは%aパッケージ、バージョン%aです。',
    userNotFoundError: '',
    wrongPasswordError: '',
    weakPasswordError: 'The password provided is too weak.',
    emailAlreadyUsedError: '',
    serverError: 'The account already exists for that email.',
    email: 'Email',
    password: 'Password',
    signIn: 'Sign In',
    signUp: 'Sign Up',
    signupSuggestion: 'Or you can Sign Up , Click here',
    signinSuggestion: 'If you already hav an account click here',
    emailFormatError: 'Email format is incorrect.',
    passwordConfirm: 'Confirm password',
    passwordNotMatch: 'Password not match.',
  };
}
