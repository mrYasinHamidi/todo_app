extension EmailValidation on String {
  bool isValidEmail({bool isRequired = true}) {
    if (!isRequired && isEmpty) return true;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(this);
  }

  bool isValidName() {
    return trim().length > 2;
  }

  bool isValidPassword() {
    return length > 7;
  }

  bool isValidUsername() {
    final usernameRegex = RegExp(
      r'^[a-zA-Z0-9._]+$',
    );

    return usernameRegex.hasMatch(this);
  }

  bool isValidPhoneNumber() {
    final usernameRegex = RegExp(
      r'^09\d{9}$',
    );

    return usernameRegex.hasMatch(this);
  }
}
