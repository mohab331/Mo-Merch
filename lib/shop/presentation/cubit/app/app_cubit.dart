import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile/user_response_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/app_theme/get_app_theme_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/app_theme/toggle_app_theme_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/on_boarding/get_on_boarding_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/user_cached_data/clear_cached_user_data_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/user_cached_data/get_cached_user_data_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/logout/logout_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_states.dart';

import '../../../../core/utils/app_functions.dart';
import '../../screens/login_screen.dart';
import '../../screens/on_boarding_screen.dart';
import '../../screens/shop_layout.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode themeMode = ThemeMode.light;
  User? user;
  dynamic showOnBoarding;
  dynamic _token;
  dynamic _userName;

  void getCachedData() {
    di.sl<GetAppThemeUseCase>().call().fold((l) {
      themeMode = ThemeMode.light;
    }, (r) {
      if (r != null) {
        if (r == true) {
          themeMode = ThemeMode.dark;
        } else {
          themeMode = ThemeMode.light;
        }
      }
    });
    di.sl<GetCachedUserDataUsecase>().call().fold((l) {
      _token = null;
      _userName = null;
    }, (userData) {
      if (userData != null) {
        _userName = json.decode(userData)['name'];
        _token = json.decode(userData)['token'];
      }
    });
    di.sl<GetOnBoardingUsecase>().call().fold((l) {}, (r) {
      if (r != null) {
        showOnBoarding = r;
      }
    });
  }

  String getUserToken() {
    if (_token != null && user == null) {
      return _token;
    } else {
      return user!.token;
    }
  }

  String getUserName() {
    if (_userName != null && user == null) {
      return _userName;
    } else {
      return user!.name;
    }
  }

  void toggleAppTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    di
        .sl<ToggleAppThemeUseCase>()
        .call(
          ToggleAppThemeUsecaseParameters(
            theme: themeMode == ThemeMode.dark ? true : false,
          ),
        )
        .then((value) {
      value.fold((l) {
        emit(AppThemeChangeErrorState(message: l.failureMessage));
      }, (r) {
        emit(AppThemeChangeState(message: AppStrings.themeChanged));
      });
    });
  }

  Widget screenToNavigate() {
    if (showOnBoarding != null) {
      if (_userName != null && _token != null) {
        return const ShopLayout();
      } else {
        return LoginScreen();
      }
    } else {
      return OnBoardingScreen();
    }
  }

  void logout(BuildContext context) async {
    emit(AppLogoutLoadingState());
    final response = await di.sl<LogoutUsecase>().call(AddUseCaseParameters(
          data: {},
          url: Endpoints.logout,
          token: getUserToken(),
        ));
    response.fold((failure) async {
      emit(AppLogoutErrorState(errorMessage: failure.failureMessage));
    }, (response) async {
      final cacheResponse =
          await di.sl<ClearCachedUserDataUsecase>().call(const NoParameters());
      cacheResponse.fold((cacheFail) {
        emit(AppLogoutErrorState(errorMessage: cacheFail.failureMessage));
      }, (r) {
        AppFunctions.navigateAndRemove(context, screen: LoginScreen());
        emit(AppLogoutUserSuccessState(message: response.message));
      });
    });
  }
}
