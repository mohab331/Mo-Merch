abstract class ChangePasswordState{
  ChangePasswordState({this.message,});
  final String? message;
}
class ChangePasswordInitialState extends ChangePasswordState{}
class ChangePasswordLoadingState extends ChangePasswordState{}
class ChangePasswordSuccessState extends ChangePasswordState{
  ChangePasswordSuccessState({super.message,});
}
class ChangePasswordErrorState extends ChangePasswordState{
  ChangePasswordErrorState({ super.message,});
}