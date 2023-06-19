import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/utils/functions.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/search/search_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/search_screen.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../cubit/app/app_cubit.dart';
import '../cubit/shop/shop_cubit.dart';
import '../cubit/shop/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
        buildWhen: (prevState, currentState) {
          return (prevState != currentState) &&
              (currentState is ShopToggleNavBarState);
        },
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Hello,  ${AppCubit.get(context).getUserName()}'),
              actions: [
                IconButton(
                  onPressed: () {
                    AppFunctions.navigateTo(
                      context: context,
                      screen: BlocProvider(
                        create: (context) => di.sl<SearchCubit>(),
                        child: SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: ShopCubit
                .get(context)
                .navBarScreens[ShopCubit
                .get(context)
                .currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: ShopCubit
                  .get(context)
                  .currentIndex,
              onTap: (int index) {
                ShopCubit.get(context).toggleNavBarCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: AppStrings.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: AppStrings.categories,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: AppStrings.favorites,
                ),
              ],
            ),
            drawer: const CustomDrawer(),
          );
        }
    );
  }
}

