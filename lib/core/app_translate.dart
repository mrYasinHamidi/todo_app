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
  static const String yourWelcome = 'yourWelcome';
  static const String today = 'today';
  static const String tomorrow = 'tomorrow';
  static const String done = 'done';
  static const String addTaskBottomMessage = 'addTaskBottomMessage';
  static const String name = 'name';
  static const String taskDescription = 'taskDescription';
  static const String dueDateHint = 'hourHint';
  static const String hideCompleted = 'hideCompleted';
  static const String showCompleted = 'showCompleted';
  static const String addTask = 'addTask';
  static const String task = 'task';
  static const String taskDescriptionError = 'taskNameError';
  static const String successMessage = 'successMessage';

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
    yourWelcome: 'Your Welcome',
    today: 'Today',
    tomorrow: 'Tomorrow',
    addTaskBottomMessage: 'If you disable today, the task will be considered as tomorrow',
    name: 'Name',
    addTask: 'Add a Task',
    task: 'Task',
    done: 'Done',
    dueDateHint: 'Due Date (Optional)',
    taskDescriptionError: 'Please write some description for your Task.',
    taskDescription: 'Task Description',
    hideCompleted: 'Hide Completed',
    showCompleted: 'Show Completed',
    successMessage: 'Operation successfully done.',
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
    yourWelcome: 'Your Welcome',
    today: 'Today',
    dueDateHint: 'Due Date (Optional)',
    tomorrow: 'Tomorrow',
    addTaskBottomMessage: 'If you disable today, the task will be considered as tomorrow',
    done: 'Done',
    hideCompleted: 'Hide Completed',
    showCompleted: 'Show Completed',
    taskDescription: 'Task Description',
    name: 'Name',
    addTask: 'Add a Task',
    taskDescriptionError: 'Please write some description for your Task.',
    successMessage: 'Operation successfully done.',
    task: 'Task',
  };
}
