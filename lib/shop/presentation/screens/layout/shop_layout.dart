import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout({
    required this.loggedInUser,
    Key? key,
  }) : super(key: key);
  static const String routeName = 'ShopLayout';
  static const String routePath = '/ShopLayout';
  final UserResponseEntity? loggedInUser;
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<ShopCubit>(),
      child: WillPopScope(
        onWillPop: () async => _handleOnWillPopUp(context),
        child: AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepOrange.withOpacity(0.8),
                  Colors.blueGrey.withOpacity(0.7)
                ],
              ),
            ),
          ),
          controller: drawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(
            milliseconds: 300,
          ),
          drawer: CustomDrawer(
            userName: loggedInUser?.name ?? '',
          ),
          child: ShopLayoutContent(
            userName: loggedInUser?.name ?? '',
            advancedDrawerController: drawerController,
          ),
        ),
      ),
    );
  }

  Future<bool> _handleOnWillPopUp(BuildContext context) async {
    return await R.functions.showCupertinoAlertDialog(
          context,
          content: const Text('Are You Sure You Wanna Exit The App'),
          title: 'Notice',
        ) ??
        false;
  }
}
