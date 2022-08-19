import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/register_screen.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/shop_layout.dart';
import '../../../core/utils/app_functions.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/default_text_form_field.dart';
import '../../../core/widgets/submit_button.dart';
import '../cubit/app/app_cubit.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      dynamic arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _emailController.text = arguments['email'];
      _passwordController.text = arguments['password'];
    }
    return BlocProvider(
      create: (context) => di.sl<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    AppStrings.loginWelcome,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(AppStrings.loginWelcomeSubtitle,
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                  DefaultTextFormField(
                    textController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    label: AppStrings.emailLabel,
                    onValidateFunction: AppFunctions.validateEmailAddress,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(
                        _passwordFocusNode,
                      );
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.05,
                  ),
                  DefaultTextFormField(
                    textController: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.password,
                    label: AppStrings.passwordLabel,
                    onValidateFunction: AppFunctions.validatePassword,
                    suffixIcon: Icons.visibility_off,
                    focusNode: _passwordFocusNode,
                    isPasswordTextFormField: true,
                    maxLength: 16,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  BlocBuilder<LoginCubit, LoginStates>(
                    buildWhen: (previous, current) =>
                        previous != current &&
                        current is LoginChangeRememberMeState,
                    builder: (context, states) {
                      return CheckboxListTile(
                        value: LoginCubit.get(context).rememberMe,
                        onChanged: (_) {
                          LoginCubit.get(context).toggleRememberMeCheckBox();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          AppStrings.rememberMe,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.forgetPassword,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  BlocConsumer<LoginCubit, LoginStates>(
                    listener: (context, states) {
                      if (states is LoginSuccessState) {
                        AppCubit.get(context).user = states.user;
                        AppFunctions.showToast(
                          message: states.message,
                          color: AppColors.successColor,
                        );
                        AppFunctions.navigateAndReplace(
                          context: context,
                          screen: const ShopLayout(),
                        );
                      } else if (states is LoginErrorState) {
                        AppFunctions.showToast(
                          message: states.error,
                          color: AppColors.errorColor,
                        );
                      } else {}
                    },
                    buildWhen: (previousState, currentState) {
                      return previousState != currentState &&
                          (currentState is! LoginChangeRememberMeState);
                    },
                    builder: (context, states) {
                      if (states is LoginLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SubmitButton(
                          label: AppStrings.login,
                          onButtonPressed: _onLoginButtonPressed,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(AppStrings.createAnAccount,
                          style: Theme.of(context).textTheme.bodyMedium),
                      TextButton(
                        onPressed: () {
                          AppFunctions.navigateTo(
                              context: context, screen: RegisterScreen());
                        },
                        child: Text(
                          AppStrings.register,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      _loginUser(context);
    }
  }

  void _loginUser(BuildContext context) {
    LoginCubit.get(context).loginUser(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
      remember: LoginCubit.get(context).rememberMe,
    );
  }
}
