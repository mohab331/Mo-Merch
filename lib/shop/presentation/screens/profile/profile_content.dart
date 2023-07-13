import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileErrorState) {
          R.functions.showToast(
            message: state.errorMessage ?? R.strings.unKnownError,
            color: R.colors.errorColor,
          );
        }
      },
      child: StateHandlingWidget(
        isLoading: (profileState is ProfileLoadingState),
        hasError: (profileState is ProfileErrorState),
        successWidget: profileState is ProfileSuccessState
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.black,
                    child: UserDataWidget(
                      userData: profileState.userProfile,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    height: 440.h,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          40.0.r,
                        ),
                        topRight: Radius.circular(
                          40.0.r,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0.h,
                        ),
                        AccountSettingsCardWidget(
                          title: R.strings.editPersonalData,
                          subtitle:
                              'when you edit your data you will be logged out',
                          onTap: (context) => _handleOnTapEditPersonalData(
                            context,
                            profileState.userProfile,
                          ),
                          trailingIcon: Icons.arrow_forward_ios,
                          leadingIcon: Icons.person_rounded,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AccountSettingsCardWidget(
                          title: R.strings.editPassword,
                          onTap: _handleOnTapEditPassword,
                          trailingIcon: Icons.arrow_forward_ios,
                          leadingIcon: Icons.password,
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }

  void _handleOnTapEditPersonalData(
      BuildContext context, UserResponseEntity user) {
    context.navigator.navigateToEditPersonalDataScreen(
      extras: user,
    );
  }

  void _handleOnTapEditPassword(BuildContext context) {
    context.navigator.navigateToChangePasswordScreen();
  }
}
