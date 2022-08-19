abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopToggleNavBarState extends ShopStates{}

class GetHomeDataLoadingState extends ShopStates{}
class GetHomeDataSuccessState extends ShopStates{}
class GetHomeDataErrorState extends ShopStates{
  final String errorMessage;
  GetHomeDataErrorState({required this.errorMessage});
}


class GetCategoryDataLoadingState extends ShopStates{}
class GetCategoryDataSuccessState extends ShopStates{}
class GetCategoryDataErrorState extends ShopStates{
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}