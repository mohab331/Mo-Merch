abstract class CategoryStates{}

class CategoryInitialState extends CategoryStates{}

class CategoryDetailsLoadingDataState extends CategoryStates{}
class CategoryDetailsSuccessDataState extends CategoryStates{}
class CategoryDetailsErrorDataState extends CategoryStates{
  final String message;
  CategoryDetailsErrorDataState({required this.message});
}

class CategoryChangeScreen extends CategoryStates{}