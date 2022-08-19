import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/login.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/user_cached_data/set_cached_user_data_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/login/login_usecase.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  late LoginResponse loginResponse;
  bool rememberMe = false;
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
    bool remember = false,
  }) async {
    emit(LoginLoadingState());

    final response = await di.sl<LoginUsecase>().call(
          AddUseCaseParameters(
            data: {
              'email': email,
              'password': password,
            },
            url: Endpoints.login,
          ),
        );
    response.fold((failure) {
      emit(LoginErrorState(error: failure.failureMessage));
    }, (response) async {
      loginResponse = response;
      if (rememberMe) {
        await di.sl<SetCachedUserDataUsecase>().call(
            SetCachedUserDataUsecaseParameters(
                token: loginResponse.user.token,
                name: loginResponse.user.name));
      }
      emit(LoginSuccessState(
          user: loginResponse.user, message: loginResponse.message));
    });
  }

  void toggleRememberMeCheckBox() {
    rememberMe = !rememberMe;
    emit(LoginChangeRememberMeState());
  }
}
