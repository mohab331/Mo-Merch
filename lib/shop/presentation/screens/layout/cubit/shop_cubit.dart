import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ShopCubit extends Cubit<ShopLayoutState> {
  ShopCubit() : super(ShopLayoutInitialState());

  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
     FavoriteScreen(),
  ];
  List<String> screenTitles = [
    R.strings.home,
    R.strings.searchLabel,
    R.strings.favorites,
  ];
  void toggleIndex(int value) {
    emit(ToggleBottomNavBarState(index: value));
  }
}
