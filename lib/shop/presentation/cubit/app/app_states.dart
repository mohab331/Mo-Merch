abstract class AppStates{}
class AppInitialState extends AppStates{}
class AppThemeChangeState extends AppStates{
  final String message;
  AppThemeChangeState({required this.message});
}
class AppThemeChangeErrorState extends AppStates{
  final String message;
  AppThemeChangeErrorState({required this.message});
}
class AppLogoutLoadingState extends AppStates{}
class AppLogoutUserSuccessState extends AppStates{
  final String message;
  AppLogoutUserSuccessState({required this.message});
}
class AppLogoutErrorState extends AppStates{
  final String errorMessage;
  AppLogoutErrorState({required this.errorMessage});
}