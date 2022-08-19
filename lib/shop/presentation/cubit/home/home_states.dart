abstract class HomeStates{}
class HomeInitialState extends HomeStates{}

class HomeToggleIsFavoriteState extends HomeStates{
  final String message;
  HomeToggleIsFavoriteState({required this.message});
}
class HomeToggleIsFavoriteErrorState extends HomeStates{
  final String message;
  HomeToggleIsFavoriteErrorState({required this.message});
}
class HomeInstantToggleIsFavoriteState extends HomeStates{}
class HomeChangeData extends HomeStates{}
