import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_toast.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/features/auth/view/viewModels/signup/signup_view_model.dart';
import 'package:todo_app/global/app_theme.dart';
import 'package:todo_app/global/extensions/string_ext.dart';
import 'package:todo_app/global/widgets/default_loading.dart';
import 'package:todo_app/global/widgets/default_text_field.dart';
import 'package:todo_app/global/widgets/item_button.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static Future open(BuildContext context) => context.pushNamed(AppRouter.signup);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final viewModel = getIt<SignupViewModel>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: _listener,
      listenWhen: (_, state) => state is SignupFailState,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                DefaultTextField(
                  controller: emailController,
                  counterText: ' ',
                  inputType: TextInputType.emailAddress,
                  label: AppTranslate.email.getString(context),
                  validator:
                      (value) =>
                          value?.isValidEmail() == true ? null : AppTranslate.emailFormatError.getString(context),
                ),
                DefaultTextField(
                  controller: passwordController,
                  label: AppTranslate.password.getString(context),
                  counterText: ' ',
                  inputType: TextInputType.visiblePassword,
                  validator:
                      (value) =>
                          value?.isValidPassword() == true ? null : AppTranslate.weakPasswordError.getString(context),
                ),
                DefaultTextField(
                  controller: confirmController,
                  label: AppTranslate.passwordConfirm.getString(context),
                  counterText: ' ',
                  inputType: TextInputType.visiblePassword,
                  validator:
                      (value) =>
                          value == passwordController.text ? null : AppTranslate.passwordNotMatch.getString(context),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  child: BlocBuilder(
                    bloc: viewModel,
                    builder: (_, state) {
                      bool loading = false;
                      if (state is SignupLoadingState) {
                        loading = true;
                      }
                      return ItemButton(
                        side: BorderSide(color: AppTheme.get().primaryColor),
                        onTap: () => loading ? null : _submit(),
                        child:
                            loading
                                ? UnconstrainedBox(child: DefaultLoading(width: 30, height: 30))
                                : Center(child: Text(AppTranslate.signUp.getString(context))),
                      );
                    },
                  ),
                ),
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ItemButton(
                      onTap: () => context.pushReplacementNamed(AppRouter.login),
                      color: Colors.transparent,
                      padding: EdgeInsets.all(4),
                      child: Text(
                        AppTranslate.signinSuggestion.getString(context),
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, SignupState state) {
    if (state is SignupFailState) {
      AppToast.show(state.errorMessage.getString(context), isError: true);
    }
  }

  void _submit() {
    if (formKey.currentState?.validate() == true) {
      viewModel.signup(emailController.text, passwordController.text);
    }
  }
}
