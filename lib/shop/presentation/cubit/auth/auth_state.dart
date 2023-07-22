import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class AuthState {
  const AuthState({this.message , this.toastColor,});
  final String? message;
  final Color? toastColor;
}

class AuthenticationInitialState extends AuthState {}

class AuthenticationLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    required this.user,
    super.message,
    super.toastColor = Colors.green,
  });
  final UserResponseEntity user;
}

class UnAuthenticatedState extends AuthState{
  const UnAuthenticatedState({
    super.message,
    super.toastColor = Colors.green,
  });
}

class AuthenticationErrorState extends AuthState {
  const AuthenticationErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}
