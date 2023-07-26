import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ShopLayoutContent extends StatelessWidget {
  const ShopLayoutContent({
    required this.advancedDrawerController,
    required this.userName,
    Key? key,
  }) : super(key: key);

  final String userName;
  final AdvancedDrawerController advancedDrawerController;

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;
    final appState = context.watch<AppCubit>().state;
    final layoutState = context.watch<ShopCubit>().state;
    final screenIndex = (layoutState is ToggleBottomNavBarState)
        ? layoutState.index
        : 0;

    return Scaffold(
      appBar: ShopLayoutAppBar(
        appBarTitle: context.read<ShopCubit>().screenTitles[screenIndex],
        controller: advancedDrawerController,
        appBar: AppBar(),
      ),
      body: StateHandlingWidget(
        isLoading: _isLoading(cartState, appState),
        onRetryButtonPressed: () => _handleOnRetry(context, cartState, appState,screenIndex,),
        hasError: _hasError(cartState, appState),
        successWidget: context.read<ShopCubit>().screens.elementAt(screenIndex),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: screenIndex,
      ),
    );
  }

  bool _isLoading(CartState cartState, AppState appState) {
    return false;
    // return appState is AppLoadingDataState || cartState is CartLoadingState;
  }

  bool _hasError(CartState cartState, AppState appState) {
    return cartState is CartErrorState || appState is AppErrorDataState;
  }

  void _handleOnRetry(
    BuildContext context,
    CartState cartState,
    AppState appState,
    int currentScreenIndex,
  ) {
    if (cartState is CartErrorState) {
      context.read<CartCubit>().getCart();
    }
    if (appState is AppErrorDataState) {
      context.read<AppCubit>().getFavoriteData(page: 1);
    }
    if (currentScreenIndex != 0) {
      context.read<ShopCubit>().toggleIndex(0);
    }
  }
}
