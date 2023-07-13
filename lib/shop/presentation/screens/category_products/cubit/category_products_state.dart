import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class CategoryProductsState{}
class CategoryProductsInitialState extends CategoryProductsState{}
class CategoryProductsLoadingState extends CategoryProductsState{}
class CategoryProductsErrorState extends CategoryProductsState{
  CategoryProductsErrorState({this.errorMessage});
  final String? errorMessage;
}
class CategoryProductsSuccessState extends CategoryProductsState{
  CategoryProductsSuccessState({required this.productsList,});
  List<ProductResponseEntity> productsList;
}