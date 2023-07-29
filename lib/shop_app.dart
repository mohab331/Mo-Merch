import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/config/index.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => diInstance.get<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => diInstance.get<CartCubit>()..getCart(),
        ),
        BlocProvider(
          create: (context) => diInstance.get<AppCubit>()
            ..getFavoriteData(
              page: 1,
            ),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: R.strings.appTitle,
            theme: AppTheme.lightTheme(),
            themeMode: ThemeMode.light,
            routerDelegate: MyRouter.router.routerDelegate,
            routeInformationParser: MyRouter.router.routeInformationParser,
            routeInformationProvider: MyRouter.router.routeInformationProvider,
          );
        },
        designSize: const Size(
          393,
          830,
        ),
        minTextAdapt: true,
        child: const SplashScreen(),
      ),
    );
  }
}
