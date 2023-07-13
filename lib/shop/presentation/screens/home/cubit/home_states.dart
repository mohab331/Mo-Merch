import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeDataLoadingState extends HomeStates {}

class HomeDataSuccessState extends HomeStates {
  HomeDataSuccessState({required this.homeResponseEntity});
  final HomeResponseEntity homeResponseEntity;
}

class HomeDataErrorState extends HomeStates {
  HomeDataErrorState({
    this.errorMessage,
  });
  final String? errorMessage;
}
