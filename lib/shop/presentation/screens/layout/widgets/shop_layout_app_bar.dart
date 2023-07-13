import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ShopLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopLayoutAppBar({
    required this.appBarTitle,
    required this.appBar,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final String appBarTitle;
  final AppBar appBar;
  final AdvancedDrawerController controller;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appBarTitle,
      ),
      leading: IconButton(
        onPressed: _handleMenuButtonPressed,
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: controller,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 250,
              ),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
              ),
            );
          },
        ),
      ),
      actions: const [
        CartIcon(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  void _handleMenuButtonPressed() {
    controller.showDrawer();
  }
}
