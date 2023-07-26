import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class LoginForm extends HookWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  // bool isRememberMeChecked = false;
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordFocusNode = useFocusNode();
    final formKey = GlobalKey<FormState>();
    final isLoginButtonLoading =
        context.watch<AuthCubit>().state is AuthenticationLoadingState;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              R.strings.loginWelcome,
              style: TextStyle(
                color: R.colors.blackColor,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              R.strings.loginWelcomeSubtitle,
              style: TextStyle(
                color: R.colors.primaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            DefaultTextFormField(
              textController: emailController,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              label: R.strings.emailLabel,
              onValidateFunction: (value) => value.validateEmailAddress(),
              onFieldSubmittedFunction: (_) =>
                  FocusScope.of(context).requestFocus(
                passwordFocusNode,
              ),
            ),
            SizedBox(
              height: 50.0.h,
            ),
            DefaultTextFormField(
              textController: passwordController,
              textInputType: TextInputType.visiblePassword,
              prefixIcon: Icons.lock,
              label: R.strings.passwordLabel,
              onValidateFunction: (value) => value.validatePassword(),
              suffixIcon: Icons.visibility_off,
              focusNode: passwordFocusNode,
              isPasswordTextFormField: true,
              maxLength: 16,
              onFieldSubmittedFunction: (_) => FocusScope.of(context).unfocus(),
            ),
            // RememberMeWidget(
            //   rememberMeCallBack: _setRememberMe,
            // ),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomTextButton(
                label: R.strings.forgetPassword,
                onPressed: () {},
              ),
            ),
            CustomElevatedButton(
              label: R.strings.login,
              onButtonPressed: (context) => _onLoginButtonPressed(
                context,
                formKey: formKey,
                loginRequestEntity: LoginRequestEntity(
                  email: emailController.text,
                  password: passwordController.text,
                  rememberMe: true,
                ),
              ),
              isLoading: isLoginButtonLoading,
              borderRadius: 40,
              buttonHeight: 50,
            ),
            SizedBox(
              height: 30.h,
            ),
            const CreateAccountRowWidget(),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginButtonPressed(
    BuildContext context, {
    required LoginRequestEntity loginRequestEntity,
    required GlobalKey<FormState> formKey,
  }) {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    formKey.currentState?.save();
    context.read<AuthCubit>().loginUser(
          loginRequestEntity: loginRequestEntity,
        );
  }

  // void _setRememberMe(bool value) {
  //   isRememberMeChecked = value;
  // }
}

