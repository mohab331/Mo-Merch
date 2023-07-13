abstract class ShopLayoutState {}

class ShopLayoutInitialState extends ShopLayoutState {}

class ToggleBottomNavBarState extends ShopLayoutState {
  ToggleBottomNavBarState({required this.index});
  final int index;
}
