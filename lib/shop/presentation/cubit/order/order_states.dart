abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

class OrderGetDataLoadingState extends OrderStates {}

class OrderGetDataSuccessState extends OrderStates {}

class OrderGetDataErrorState extends OrderStates {
  final String errorMessage;
  OrderGetDataErrorState({required this.errorMessage});
}

class OrderGetDetailsDataLoadingState extends OrderStates {}

class OrderGetDetailsDataSuccessState extends OrderStates {}

class OrderGetDetailsDataErrorState extends OrderStates {
  final String errorMessage;
  OrderGetDetailsDataErrorState({required this.errorMessage});
}
