import '../../../domain/entities/user.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final User user;
  final String message;
  LoginSuccessState({required this.user,required this.message,});
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState({required this.error});
}

class LoginChangeRememberMeState extends LoginStates{}
