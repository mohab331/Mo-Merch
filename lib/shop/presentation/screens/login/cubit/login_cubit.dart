import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(
          LoginInitialState(),
        );

   bool? rememberMeValue;
  void toggleRememberMe(bool value) {
    rememberMeValue = value;
    emit(ToggleRememberMe());
  }
}
