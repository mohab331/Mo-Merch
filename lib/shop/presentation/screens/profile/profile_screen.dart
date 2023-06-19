import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';

import '../../../../core/widgets/custom_list_tile.dart';
import '../../cubit/app/app_cubit.dart';
import '../../cubit/profile/profile_cubit.dart';
import '../../cubit/profile/profile_states.dart';
import 'edit_password_screen.dart';
import 'edit_personal_data_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, states) async {
        if (states is ProfileSuccessState) {
          await AppFunctions.showCupertinoAlertDialog(context,
              content: const Text(AppStrings.cupertinoProfileContent),
              title: AppStrings.cupertinoProfileTitle);
        }
        if (states is ProfileErrorState) {
          AppFunctions.showToast(
              message: states.errorMessage, color: AppColors.successColor);
        }
      },
      buildWhen: (previousState, currentState) {
        return previousState != currentState &&
            (currentState is ProfileSuccessState ||
                currentState is ProfileErrorState ||
                currentState is ProfileLoadingState);
      },
      listenWhen: (previousState, currentState) {
        return previousState != currentState &&
            (currentState is ProfileSuccessState ||
                currentState is ProfileErrorState ||
                currentState is ProfileLoadingState);
      },
      builder: (context, states) {
        if (states is ProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (states is ProfileErrorState) {
          return NetworkErrorWidget(
              onReloadButtonPressed: (BuildContext context) {
            ProfileCubit.get(context).getUserProfile(context);
          });
        } else if (states is ProfileSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.appBarProfileTitle),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: context.height * 0.25,
                        color: Colors.grey[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 60.0,
                            ),
                            SizedBox(
                              height: context.height * 0.015,
                            ),
                            Text(
                              ProfileCubit.get(context).user!.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${AppStrings.credit}${ProfileCubit.get(context).user!.credit.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * 0.015,
                                ),
                                Text(
                                  '${AppStrings.orderPoints}${ProfileCubit.get(context).user!.points.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.05,
                      ),
                      Card(
                        elevation: 10.0,
                        color: AppCubit.get(context).themeMode == ThemeMode.dark
                            ? Colors.grey
                            : Colors.white,
                        child: CustomListTile(
                          title: AppStrings.editPersonalData,
                          leadingIcon: Icons.person_rounded,
                          onListTileTapFunction: () {
                            AppFunctions.navigateTo(
                              context: context,
                              screen: BlocProvider.value(
                                value: ProfileCubit.get(context),
                                child: EditPersonalDataScreen(
                                    email:
                                        ProfileCubit.get(context).user!.email,
                                    name: ProfileCubit.get(context).user!.name,
                                    phoneNumber:
                                        ProfileCubit.get(context).user!.phone),
                              ),
                            );
                          },
                          trailingIcon: Icons.arrow_forward_ios,
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.015,
                      ),
                      Card(
                          elevation: 10.0,
                          color:
                              AppCubit.get(context).themeMode == ThemeMode.dark
                                  ? Colors.grey
                                  : Colors.white,
                          child: CustomListTile(
                            title: AppStrings.editPassword,
                            leadingIcon: Icons.password,
                            onListTileTapFunction: () {
                              AppFunctions.navigateTo(
                                  context: context,
                                  screen: BlocProvider.value(
                                    value: ProfileCubit(),
                                    child: EditPasswordScreen(),
                                  ));
                            },
                            trailingIcon: Icons.arrow_forward_ios,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
