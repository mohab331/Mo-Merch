
abstract class ProductDescriptionStates{}
class ProductDescriptionInitialState extends ProductDescriptionStates{}

class ProductDescriptionLoadingAddState extends ProductDescriptionStates{}

//cart
class ProductDescriptionAddOrRemoveProductFromCartSuccessState extends ProductDescriptionStates{
  ProductDescriptionAddOrRemoveProductFromCartSuccessState({required this.message});
  final String message;
}
class ProductDescriptionAddOrRemoveProductFromCartErrorState extends ProductDescriptionStates{
  ProductDescriptionAddOrRemoveProductFromCartErrorState({required this.message});
  final String message;
}


//favorite
class ProductDescriptionToggleFavoritesInstantState extends ProductDescriptionStates{}
class ProductDescriptionToggleFavoritesState extends ProductDescriptionStates{
  ProductDescriptionToggleFavoritesState({required this.message});
  final String message;
}
class ProductDescriptionErrorState extends ProductDescriptionStates{
  final String message;
  ProductDescriptionErrorState({required this.message,});

}

