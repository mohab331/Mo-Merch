import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  CategorySuccessState({
    required this.categoriesList,
  });
  final List<CategoryResponseEntity> categoriesList;
}

class CategoryErrorState extends CategoryState {
  CategoryErrorState({
    this.errorMessage,
  });
  final String? errorMessage;
}
