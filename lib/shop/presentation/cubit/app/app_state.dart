import 'package:flutter/material.dart';

abstract class AppState {
  const AppState({this.message, this.toastColor});
  final String? message;
  final Color? toastColor;
}

class AppInitialState extends AppState {}

class AppThemeChangeState extends AppState {
  AppThemeChangeState({
    super.message,
    super.toastColor,
  });
}

class AppLoadingDataState extends AppState {}

class AppSuccessDataState extends AppState {}

class AppErrorDataState extends AppState {
  const AppErrorDataState({
    super.message,
    super.toastColor,
  });
}

class AppThemeChangeErrorState extends AppState {
  const AppThemeChangeErrorState({
    super.message,
    super.toastColor,
  });
}
