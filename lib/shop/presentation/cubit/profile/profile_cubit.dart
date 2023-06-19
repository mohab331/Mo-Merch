import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/profile/change_password_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/profile/get_profile_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/profile/update_profile_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/profile/profile_states.dart';

import '../../../domain/entities/profile/user_response_model.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  User? user;

  void getUserProfile(BuildContext context) async {
    emit(ProfileLoadingState());
    final response = await di.sl<GetProfileUseCase>().call(GetUseCaseParameters(
          token: AppCubit.get(context).getUserToken(),
          url: Endpoints.profile,
        ));
    response.fold((failure) {
      emit(ProfileErrorState(errorMessage: failure.failureMessage));
    }, (profileResponse) {
      user = profileResponse.user;
      emit(ProfileSuccessState());
    });
  }

  void updateUserProfile(
    BuildContext context, {
    required Map<String, dynamic> userDataMap,
  }) async {
    emit(ProfileUpdatePersonalDataLoadingState());
    final response = await di.sl<UpdateProfileUseCase>().call(
        UpdateUseCaseParameters(
            data: userDataMap,
            token: AppCubit.get(context).getUserToken(),
            url: Endpoints.updateProfile));
    response.fold((failure) {
      emit(ProfileUpdatePersonalDataErrorState(
          errorMessage: failure.failureMessage));
    }, (profileResponse) {
      emit(ProfileUpdatePersonalDataSuccessState(
          updateMessage: profileResponse.message!));
    });
  }

  void changeUserPassword(BuildContext context,
      {required Map<String, dynamic> data}) async {
    emit(ProfileUpdatePasswordLoadingState());
    final response = await di.sl<ChangePasswordUsecase>().call(
        AddUseCaseParameters(
            data: data,
            url: Endpoints.changePassword,
            token: AppCubit.get(context).getUserToken()));
    response.fold((failure) {
      emit(
        ProfileUpdatePasswordErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (changePasswordResponse) {
      emit(
        ProfileUpdatePasswordSuccessState(
          updateMessage: changePasswordResponse.message,
        ),
      );
    });
  }
}
