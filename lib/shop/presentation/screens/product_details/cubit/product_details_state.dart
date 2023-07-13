import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class ProductDescriptionState {}

class ProductDescriptionInitialState extends ProductDescriptionState {}

class ProductDescriptionLoadingState extends ProductDescriptionState {}

class ProductDescriptionSuccessState extends ProductDescriptionState {
  ProductDescriptionSuccessState({
    required this.productResponseEntity,
  });
  final ProductResponseEntity productResponseEntity;
}

class ProductDescriptionErrorState extends ProductDescriptionState {
  ProductDescriptionErrorState({
    required this.errorMessage,
  });
  final String? errorMessage;
}
