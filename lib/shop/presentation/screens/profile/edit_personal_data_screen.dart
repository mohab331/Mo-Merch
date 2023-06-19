import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';

import '../../../../core/widgets/default_text_form_field.dart';
import '../../../../core/widgets/submit_button.dart';
import '../../cubit/app/app_cubit.dart';
import '../../cubit/profile/profile_cubit.dart';
import '../../cubit/profile/profile_states.dart';

class EditPersonalDataScreen extends StatefulWidget {
  const EditPersonalDataScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);
  final String name;
  final String email;
  final String phoneNumber;

  @override
  State<EditPersonalDataScreen> createState() => _EditPersonalDataScreenState();
}

class _EditPersonalDataScreenState extends State<EditPersonalDataScreen> {
   final TextEditingController _emailTextEditingController =
      TextEditingController();

   final TextEditingController _nameTextEditingController =
      TextEditingController();

   final TextEditingController _phoneTextEditingController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();

  final FocusNode _phoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _emailTextEditingController.text = widget.email;
    _nameTextEditingController.text = widget.name;
    _phoneTextEditingController.text = widget.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarPersonalDataTitle),
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
                    textController: _emailTextEditingController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    label: AppStrings.emailLabel,
                    onValidateFunction: AppFunctions.validateEmailAddress,
                    onFieldSubmittedFunction: (BuildContext context) {
                      FocusScope.of(context).requestFocus(_nameFocusNode);
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  DefaultTextFormField(
                    textController: _nameTextEditingController,
                    textInputType: TextInputType.name,
                    prefixIcon: Icons.person_rounded,
                    label: AppStrings.nameLabel,
                    onValidateFunction: AppFunctions.validateName,
                    focusNode: _nameFocusNode,
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
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  BlocConsumer<ProfileCubit, ProfileStates>(
                    buildWhen: (previousState, currentState) {
                      return previousState != currentState &&
                          (currentState is! ProfileUpdatePasswordLoadingState &&
                                  currentState
                                      is! ProfileUpdatePasswordLoadingState ||
                              currentState is! ProfileUpdatePasswordErrorState);
                    },
                    listenWhen: (previousState, currentState) {
                      return previousState != currentState &&
                          (currentState is! ProfileUpdatePasswordLoadingState &&
                                  currentState
                                      is! ProfileUpdatePasswordSuccessState ||
                              currentState is! ProfileUpdatePasswordErrorState);
                    },
                    listener: (context, states) async {
                      if (states is ProfileUpdatePersonalDataSuccessState) {
                        AppFunctions.showToast(
                            message: states.updateMessage,
                            color: AppColors.successColor);
                        AppCubit.get(context).logout(context);
                      } else if (states
                          is ProfileUpdatePersonalDataErrorState) {
                        AppFunctions.showToast(
                          message: states.errorMessage,
                          color: AppColors.errorColor,
                        );
                      }
                    },
                    builder: (context, states) {
                      return states is ProfileUpdatePersonalDataLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SubmitButton(
                              label: AppStrings.updatePersonalData,
                              onButtonPressed: onUpdateButtonPressed,
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

  void onUpdateButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      ProfileCubit.get(context).updateUserProfile(
        context,
        userDataMap: {
          'name': _nameTextEditingController.text,
          'email': _emailTextEditingController.text,
          'phone': _phoneTextEditingController.text,
        },
      );
    }
  }
}
