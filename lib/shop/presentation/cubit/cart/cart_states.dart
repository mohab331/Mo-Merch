
abstract class CartStates{}

class CartInitialState extends CartStates{}
class CartLoadingState extends CartStates{}
class CartSuccessDataState extends CartStates{}
class CartErrorDataState extends CartStates{
  final String errorMessage;
  CartErrorDataState({required this.errorMessage});
}

class CartDeleteItemSuccessState extends CartStates{
  final String message;
  CartDeleteItemSuccessState({required this.message });
}
class CartDeleteItemErrorState extends CartStates{
  final String message;
  CartDeleteItemErrorState({required this.message});
}
class CartInstantDeleteItemState extends CartStates{}


class CartUpdateItemSuccessState extends CartStates{
  final String message;
  CartUpdateItemSuccessState({required this.message});
}
class CartUpdateItemErrorState extends CartStates{
  final String message;
  CartUpdateItemErrorState({required this.message});
}
class CartUpdateItemInstantState extends CartStates{}