import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class EditPersonalDataContent extends StatefulWidget {
  const EditPersonalDataContent({required this.userData, Key? key})
      : super(key: key);
  final UserResponseEntity userData;
  @override
  State<EditPersonalDataContent> createState() =>
      _EditPersonalDataContentState();
}

class _EditPersonalDataContentState extends State<EditPersonalDataContent> {
  final GlobalKey<FormState> formKey = GlobalKey();

  late final TextEditingController nameTextEditingController;
  late final FocusNode nameFocusNode;
  late final TextEditingController emailTextEditingController;
  late final TextEditingController phoneTextEditingController;
  late final FocusNode phoneFocusNode;

  @override
  void initState() {
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();

    nameTextEditingController = TextEditingController(
      text: widget.userData.name,
    );

    emailTextEditingController =
        TextEditingController(text: widget.userData.email);
    phoneTextEditingController =
        TextEditingController(text: widget.userData.phone);
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    phoneFocusNode.dispose();

    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    phoneTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editPersonalDataState = context.watch<EditPersonalDataCubit>().state;
    return BlocListener<EditPersonalDataCubit, EditPersonalDataState>(
      listener: (context, state) {
        if (state.message != null) {
          final toastColor =
              state is EditPersonalDataSuccessState ? Colors.green : Colors.red;
          R.functions.showToast(
            message: state.message!,
            color: toastColor,
          );
        }
        if (state is EditPersonalDataSuccessState) {
          context.read<AuthCubit>().logout();
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DefaultTextFormField(
                textController: emailTextEditingController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                label: R.strings.emailLabel,
                onValidateFunction: (value) => value?.validateEmailAddress(),
                onFieldSubmittedFunction: (_) =>
                    FocusScope.of(context).requestFocus(nameFocusNode),
              ),
              SizedBox(
                height: 30.h,
              ),
              DefaultTextFormField(
                textController: nameTextEditingController,
                textInputType: TextInputType.name,
                prefixIcon: Icons.person_rounded,
                label: R.strings.nameLabel,
                onValidateFunction: (value) => value?.validateUserName(),
                focusNode: nameFocusNode,
                onFieldSubmittedFunction: (_) =>
                    FocusScope.of(context).requestFocus(phoneFocusNode),
              ),
              SizedBox(
                height: 30.h,
              ),
              DefaultTextFormField(
                textController: phoneTextEditingController,
                textInputType: TextInputType.phone,
                prefixIcon: Icons.phone,
                label: R.strings.phoneNumberLabel,
                onValidateFunction: (value) => value?.validateIsEmpty(),
                focusNode: phoneFocusNode,
                onFieldSubmittedFunction: (_) =>
                    FocusScope.of(context).unfocus(),
              ),
              SizedBox(
                height: 40.h,
              ),
              customElevatedButton(
                label: R.strings.updatePersonalData,
                onButtonPressed: (context) => onUpdateButtonPressed(
                  context,
                  userUpdatedData: UpdateProfileRequestEntity(
                      name : nameTextEditingController.text,
                      email:emailTextEditingController.text,
                      phone:phoneTextEditingController.text,
                  ),
                ),
                buttonHeight: 80.h,
                borderRadius: 30.r,
                isLoading:
                    editPersonalDataState is EditPersonalDataLoadingState,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onUpdateButtonPressed(
    BuildContext context, {
    required UpdateProfileRequestEntity userUpdatedData,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<EditPersonalDataCubit>().updateUserProfile(
            updateProfileRequestEntity: userUpdatedData,
          );
    }
  }
}
