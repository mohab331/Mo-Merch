
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class SearchState{}
class SearchInitialState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchSuccessState extends SearchState{
  SearchSuccessState({required this.products,});
  final List<ProductResponseEntity> products;
}
class SearchErrorState extends SearchState{
  SearchErrorState({this.errorMessage,});
  final String? errorMessage;
}