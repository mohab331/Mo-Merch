import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout({
    Key? key,
  }) : super(key: key);
  static const String routeName = 'ShopLayout';
  static const String routePath = '/ShopLayout';
  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final user = context
        .read<AuthCubit>()
        .loggedInUser;
    return BlocProvider(
      create: (context) => diInstance.get<ShopCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is UnAuthenticatedState){
            context.navigator.navigateToLoginScreen();
            R.functions.showToast(message: state.message ?? 'Logged Out', color: state.toastColor ?? Colors.green,);
          }
        },
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
              userName: user?.name ?? '',
            ),
            child: ShopLayoutContent(
              userName: user?.name ?? '',
              advancedDrawerController: drawerController,
            ),
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
