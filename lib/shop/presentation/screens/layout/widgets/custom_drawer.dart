import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_cubit.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({required this.userName, Key? key,}) : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150.h,
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Welcome, $userName',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DrawerTileWidget(
                    title: 'Switch mode',
                    icon: Icons.mode_night,
                    onItemTapped: () {
                      // Todo Implement
                    },
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
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white54,
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

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({
    required this.title,
    required this.icon,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);
  final Function() onItemTapped;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onItemTapped,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
