import 'package:shop_app_clean_architecture/utils/index.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashSuccessState extends SplashState {
  SplashSuccessState({
    required this.userDataResponseEntity,
    required this.showOnBoarding,
    required this.appTheme,
  });
  final bool showOnBoarding;
  final AppThemeEnum appTheme;
  final UserResponseEntity? userDataResponseEntity;
}

class SplashErrorState extends SplashState {}
