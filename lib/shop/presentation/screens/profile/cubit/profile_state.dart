import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  ProfileSuccessState({
    required this.userProfile,
    this.successMessage,
  });
  final UserResponseEntity userProfile;
  final String? successMessage;
}

class ProfileErrorState extends ProfileState {
  ProfileErrorState({
    this.errorMessage,
  });
  final String? errorMessage;
}
