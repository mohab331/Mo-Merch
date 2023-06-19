import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/functions.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/default_text_form_field.dart';
import '../../../../core/widgets/submit_button.dart';
import '../../cubit/profile/profile_cubit.dart';
import '../../cubit/profile/profile_states.dart';


class EditPasswordScreen extends StatelessWidget {
  EditPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _oldPasswordTextEditingController =
  TextEditingController();
  final TextEditingController _newPasswordTextEditingController =
  TextEditingController();

  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarChangePasswordTitle),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DefaultTextFormField(
                    textController: _oldPasswordTextEditingController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.password,
                    label: AppStrings.oldPasswordLabel,
                    onValidateFunction: AppFunctions.validatePassword,
                    isPasswordTextFormField: true,
                    suffixIcon: Icons.visibility_off,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(
                        _newPasswordFocusNode,
                      );
                    },
                  ),
                   SizedBox(
                    height: context.height * 0.02,
                  ),
                  DefaultTextFormField(
                    textController: _newPasswordTextEditingController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.password,
                    label: AppStrings.newPasswordLabel,
                    onValidateFunction: AppFunctions.validatePassword,
                    isPasswordTextFormField: true,
                    suffixIcon: Icons.visibility_off,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(
                        _confirmPasswordFocusNode,
                      );
                    },
                    focusNode: _newPasswordFocusNode,
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),

                  BlocConsumer<ProfileCubit, ProfileStates>(
                    listener: (context, states) {
                      if (states is ProfileUpdatePasswordSuccessState) {
                        AppFunctions.showToast(
                            message: states.updateMessage, color: AppColors.successColor);
                      }
                      if (states is ProfileUpdatePasswordErrorState) {
                        AppFunctions.showToast(
                          message: states.errorMessage,
                          color: AppColors.errorColor,
                        );
                      }
                    },
                    buildWhen: (previousState, currentState) {
                      return previousState != currentState &&
                          (currentState is ProfileUpdatePasswordSuccessState ||
                              currentState is ProfileUpdatePasswordErrorState ||
                              currentState
                              is ProfileUpdatePasswordLoadingState);
                    },
                    builder: (context, states) {
                      return states is ProfileUpdatePasswordLoadingState
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : SubmitButton(
                        label: AppStrings.changePassword,
                        onButtonPressed: onSaveButtonPressed,
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

  void onSaveButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ProfileCubit.get(context).changeUserPassword(
        context,
        data: {
          'current_password': _oldPasswordTextEditingController.text,
          'new_password': _newPasswordTextEditingController.text,
        },
      );
    }
  }
}
