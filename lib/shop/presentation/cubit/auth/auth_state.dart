import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class AuthState {
  const AuthState();
}

class AuthenticationInitialState extends AuthState {}

class AuthenticationLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    required this.user,
    this.successMessage,
  });
  final UserResponseEntity user;
  final String? successMessage;
}

class UnAuthenticatedState extends AuthState{
  const UnAuthenticatedState(this.successMessage,);
  final String? successMessage;
}

class AuthenticationErrorState extends AuthState {
  const AuthenticationErrorState({
    required this.errorMessage,
  });
  final String? errorMessage;
}
