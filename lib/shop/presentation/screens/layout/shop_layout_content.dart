import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';


class ShopLayoutContent extends StatelessWidget {
  ShopLayoutContent({
    required this.advancedDrawerController,
    required this.userName,
    Key? key,
  }) : super(key: key);
  final String userName;
  final AdvancedDrawerController advancedDrawerController;
  @override
  Widget build(BuildContext context) {
    print('Rebuild Shop Layout');
    return BlocBuilder<ShopCubit, ShopLayoutState>(
      builder: (context, state) {
        final screenIndex =
            (state is ToggleBottomNavBarState) ? state.index : 0;
        return Scaffold(
          appBar: ShopLayoutAppBar(
            appBarTitle: context.read<ShopCubit>().screenTitles[screenIndex],
            controller: advancedDrawerController,
            appBar: AppBar(),
          ),
          body: context.read<ShopCubit>().screens.elementAt(
                screenIndex,
              ),
          extendBody: true,
          bottomNavigationBar: BottomNavBar(
            currentIndex: screenIndex,
          ),
        );
      },
    );
  }
}
