import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class ChangePasswordContent extends HookWidget {
  ChangePasswordContent({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final oldPasswordTextEditingController = useTextEditingController();
    final newPasswordTextEditingController = useTextEditingController();
    final confirmPasswordTextEditingController = useTextEditingController();

    final newPasswordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

    final changePasswordState = context.watch<ChangePasswordCubit>().state;
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.message != null) {
          final toastColor = state is ChangePasswordSuccessState
              ? R.colors.greenColor
              : R.colors.redColor;
          R.functions.showToast(
            message: state.message ?? '',
            color: toastColor,
          );
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create new password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Your new password must be different from previous used password.',
                style: TextStyle(
                  color: R.colors.greyColor,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              DefaultTextFormField(
                textController: oldPasswordTextEditingController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.lock,
                label: R.strings.oldPasswordLabel,
                onValidateFunction: (value) => value.validatePassword(),
                isPasswordTextFormField: true,
                onFieldSubmittedFunction: (_) =>
                    FocusScope.of(context).requestFocus(
                  confirmPasswordFocusNode,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              DefaultTextFormField(
                textController: newPasswordTextEditingController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.lock,
                label: R.strings.newPasswordLabel,
                onValidateFunction: (value) => value.validatePassword(),
                isPasswordTextFormField: true,
                focusNode: newPasswordFocusNode,
                onFieldSubmittedFunction: (_) =>
                    FocusScope.of(context).requestFocus(
                  confirmPasswordFocusNode,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              DefaultTextFormField(
                textController: confirmPasswordTextEditingController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.lock,
                label: 'Confirm password',
                onValidateFunction: (value) => _validateConfirmPassword(
                  value,
                  newPasswordTextEditingController.text,
                ),
                isPasswordTextFormField: true,
                focusNode: confirmPasswordFocusNode,
                onFieldSubmittedFunction: (_) =>
                    FocusScope.of(context).unfocus(),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomElevatedButton(
                label: 'Change',
                isLoading: changePasswordState is ChangePasswordLoadingState,
                onButtonPressed: (context) => _onChangeTapped(
                  context,
                  oldPassword: oldPasswordTextEditingController.text,
                  newPassword: newPasswordTextEditingController.text,
                ),
                buttonHeight: 50,
                borderRadius: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateConfirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword != password) {
      return 'password doesn\'t match new password';
    }
    return null;
  }

  void _onChangeTapped(
    BuildContext context, {
    required String oldPassword,
    required String newPassword,
  }) {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      context.read<ChangePasswordCubit>().changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
          );
    }
  }
}
