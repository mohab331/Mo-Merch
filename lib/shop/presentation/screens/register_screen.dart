import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/register/register_cubit.dart';

import '../../../core/widgets/default_text_form_field.dart';
import '../../../core/widgets/submit_button.dart';
import '../cubit/register/register_states.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<RegisterCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.register,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                  DefaultTextFormField(
                    textController: _nameController,
                    textInputType: TextInputType.name,
                    prefixIcon: Icons.person_rounded,
                    label: AppStrings.nameLabel,
                    onValidateFunction: AppFunctions.validateName,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  DefaultTextFormField(
                    textController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    label: AppStrings.emailLabel,
                    onValidateFunction: AppFunctions.validateEmailAddress,
                    focusNode: _emailFocusNode,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  DefaultTextFormField(
                    isPasswordTextFormField: true,
                    suffixIcon: Icons.visibility_off,
                    maxLength: 16,
                    textController: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.password,
                    label: AppStrings.passwordLabel,
                    onValidateFunction: AppFunctions.validatePassword,
                    focusNode: _passwordFocusNode,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(_phoneFocusNode);
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  DefaultTextFormField(
                    textController: _phoneTextEditingController,
                    textInputType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                    label: AppStrings.phoneNumberLabel,
                    onValidateFunction: AppFunctions.validatePhoneNumber,
                    focusNode: _phoneFocusNode,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).removeListener(() {});
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  BlocConsumer<RegisterCubit, RegisterStates>(
                    listener: (context, states) {
                      if (states is RegisterSuccessState) {
                        AppFunctions.navigateAndRemove(
                            context,
                            screen: LoginScreen(),
                            arguments: {
                              'email': _emailController.text,
                              'password': _passwordController.text,
                            });
                        AppFunctions.showToast(
                            message: states.message,
                            color: AppColors.successColor);
                      }
                      if (states is RegisterErrorState) {
                        AppFunctions.showToast(
                          message: states.error,
                          color: AppColors.errorColor,
                        );
                      }
                    },
                    builder: (context, states) {
                      return states is RegisterLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SubmitButton(
                              label: AppStrings.register,
                              onButtonPressed: registerButtonPressed,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      RegisterCubit.get(context).registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phoneNumber: _phoneTextEditingController.text,
      );
    }
  }
}
