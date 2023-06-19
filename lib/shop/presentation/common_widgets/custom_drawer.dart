import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/functions.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/cart/cart_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/order/order_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/profile/profile_cubit.dart';

import '../../shop/presentation/cubit/app/app_cubit.dart';
import '../../shop/presentation/screens/cart_screen.dart';
import '../../shop/presentation/screens/order_screen.dart';
import '../../shop/presentation/screens/profile/profile_screen.dart';
import '../utils/app_strings.dart';
import 'custom_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: context.height * 0.2,
                width: double.infinity,
                alignment: Alignment.bottomRight,
                color: Colors.grey,
                child: IconButton(
                  onPressed: () {
                    AppCubit.get(context).toggleAppTheme();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              CustomListTile(
                title: AppStrings.drawerOrder,
                leadingIcon: Icons.shopping_bag,
                onListTileTapFunction: () {
                  AppFunctions.navigateTo(context: context, screen: BlocProvider(create: (context) => di.sl<OrderCubit>()..getOrders(context),child: const OrderScreen()));
                },
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              CustomListTile(
                title: AppStrings.drawerCart,
                leadingIcon: Icons.shopping_cart,
                onListTileTapFunction: () {
                  AppFunctions.navigateTo(
                      context: context,
                      screen: BlocProvider(
                          create: (context) =>
                              di.sl<CartCubit>()..getCartData(context),
                          child: const CartScreen()));
                },
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              CustomListTile(
                title: AppStrings.drawerProfile,
                leadingIcon: Icons.account_circle,
                onListTileTapFunction: () {
                  AppFunctions.navigateTo(
                      context: context,
                      screen: BlocProvider(
                        create: (context) =>
                            di.sl<ProfileCubit>()..getUserProfile(context),
                        child: const EditProfileScreen(),
                      ));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomListTile(
                title: AppStrings.drawerLogout,
                leadingIcon: Icons.logout_outlined,
                onListTileTapFunction: () {
                  AppCubit.get(context).logout(context);
                }),
          ),
        ],
      ),
    );
  }
}
