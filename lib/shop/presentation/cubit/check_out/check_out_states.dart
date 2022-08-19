abstract class CheckOutStates{}
class CheckOutInitialState extends CheckOutStates{}
class CheckOutToggleState extends CheckOutStates{}

class CheckOutLoadingState extends CheckOutStates{}
class CheckOutSuccessState extends CheckOutStates{
  final String message;
  CheckOutSuccessState({required this.message});
}
class CheckOutErrorState extends CheckOutStates{
  final String error;
  CheckOutErrorState({required this.error,});
}


