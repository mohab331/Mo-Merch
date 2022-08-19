abstract class FavoriteState{}

class FavoriteInitialState extends FavoriteState{}
class FavoriteLoadingDataState extends FavoriteState{}
class FavoriteSuccessDataState extends FavoriteState{}
class FavoriteErrorDataState extends FavoriteState{
  final String errorMessage;
  FavoriteErrorDataState({required this.errorMessage});
}
class FavoriteChangeScreenState extends FavoriteState{}

class FavoriteDeleteItemInstantState extends FavoriteState{}
class FavoriteDeleteItemSuccessState extends FavoriteState{
  final String message;
  FavoriteDeleteItemSuccessState({required this.message});
}