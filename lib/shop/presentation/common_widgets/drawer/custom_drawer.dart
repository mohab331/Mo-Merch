import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({required this.userName, Key? key,}) : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: R.colors.whiteColor,
        iconColor: R.colors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150.h,
                    padding: EdgeInsets.symmetric(
                        vertical: 30.h, horizontal: 20.w,),
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Welcome, $userName',
                        style: TextStyle(
                          color: R.colors.whiteColor,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DrawerTileWidget(
                    title: R.strings.orders,
                    icon: Icons.price_check,
                    onItemTapped: () => context.navigator.navigateToOrderScreen(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerTileWidget(
                    title: R.strings.categories,
                    icon: Icons.category,
                    onItemTapped: () {
                      context.navigator.navigateToCategoryScreen();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerTileWidget(
                    title: R.strings.profile,
                    icon: Icons.account_circle_rounded,
                    onItemTapped: () => context.navigator.navigateToProfileScreen(),
                  ),
                  const Spacer(),

                ],
              ),
            ),
            DrawerTileWidget(
              title: R.strings.logout,
              icon: Icons.logout,
              onItemTapped: () => context.read<AuthCubit>().logout(),
              isLoading: context.watch<AuthCubit>().state
                  is AuthenticationLoadingState,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.sp,
                color: R.colors.lightWhite,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: const Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

