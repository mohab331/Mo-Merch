import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_state.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class RegisterForm extends HookWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = useTextEditingController();
    final emailFocusNode = useFocusNode();
    final emailController = useTextEditingController();
    final passwordFocusNode = useFocusNode();
    final passwordController = useTextEditingController();
    final phoneFocusNode = useFocusNode();
    final phoneController = useTextEditingController();
    final isRegisterButtonLoading =
        context.watch<AuthCubit>().state == AuthenticationLoadingState();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              R.strings.register,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0.h,
            ),
            DefaultTextFormField(
              textController: nameController,
              textInputType: TextInputType.name,
              prefixIcon: Icons.person_rounded,
              label: R.strings.nameLabel,
              onValidateFunction: (value) => value?.validateUserName(),
              onFieldSubmittedFunction: (_) =>
                  FocusScope.of(context).requestFocus(emailFocusNode),
            ),
            SizedBox(
              height: 30.h,
            ),
            DefaultTextFormField(
              textController: emailController,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              label: R.strings.emailLabel,
              onValidateFunction: (value) => value?.validateEmailAddress(),
              focusNode: emailFocusNode,
              onFieldSubmittedFunction: (_) =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            SizedBox(
              height: 30.h,
            ),
            DefaultTextFormField(
              isPasswordTextFormField: true,
              suffixIcon: Icons.visibility_off,
              maxLength: 16,
              textController: passwordController,
              textInputType: TextInputType.visiblePassword,
              prefixIcon: Icons.password,
              label: R.strings.passwordLabel,
              onValidateFunction: (value) => value?.validatePassword(),
              focusNode: passwordFocusNode,
              onFieldSubmittedFunction: (_) =>
                  FocusScope.of(context).requestFocus(phoneFocusNode),
            ),
            SizedBox(
              height: 30.h,
            ),
            DefaultTextFormField(
              textController: phoneController,
              textInputType: TextInputType.phone,
              prefixIcon: Icons.phone,
              label: R.strings.phoneNumberLabel,
              onValidateFunction: (value) => value?.validateIsEmpty(),
              focusNode: phoneFocusNode,
              onFieldSubmittedFunction: (_) => FocusScope.of(context).unfocus(),
            ),
            SizedBox(
              height: 50.h,
            ),
            customElevatedButton(
              label: R.strings.register,
              isLoading: isRegisterButtonLoading,
              onButtonPressed: (context) => _onRegisterButtonPressed(
                context,
                user: RegisterRequestEntity(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  phone: phoneController.text,
                  image: R.constants.image,
                ),
                formKey: formKey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterButtonPressed(
    BuildContext context, {
    required RegisterRequestEntity user,
    required GlobalKey<FormState> formKey,
  }) {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    formKey.currentState?.save();
    context.read<AuthCubit>().registerUser(
          registerRequestEntity: user,
        );
  }
}
