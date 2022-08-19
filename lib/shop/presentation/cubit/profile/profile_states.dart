abstract class ProfileStates {}
class ProfileInitialState extends ProfileStates{}
class ProfileLoadingState extends ProfileStates{}
class ProfileSuccessState extends ProfileStates{}
class ProfileErrorState extends ProfileStates{
  final String errorMessage;
  ProfileErrorState({required this.errorMessage});
}


class ProfileUpdatePersonalDataLoadingState extends ProfileStates{}
class ProfileUpdatePersonalDataErrorState extends ProfileStates{
  final String errorMessage;
  ProfileUpdatePersonalDataErrorState({required this.errorMessage});
}
class ProfileUpdatePersonalDataSuccessState extends ProfileStates{
  final String updateMessage;
  ProfileUpdatePersonalDataSuccessState({required this.updateMessage});
}

class ProfileUpdatePasswordLoadingState extends ProfileStates{}
class ProfileUpdatePasswordSuccessState extends ProfileStates{
  final String updateMessage;
  ProfileUpdatePasswordSuccessState({required this.updateMessage});
}
class ProfileUpdatePasswordErrorState extends ProfileStates{
  final String errorMessage;
  ProfileUpdatePasswordErrorState({required this.errorMessage});
}