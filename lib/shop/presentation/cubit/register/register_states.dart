abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final String message;
  RegisterSuccessState({required this.message });
}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState({required this.error});
}