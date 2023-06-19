import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/config/app_theme/app_theme.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AppCubit>()..getCachedData(),),
        BlocProvider(create: (context) => di.sl<ShopCubit>()..getHomeData(context)),
      ],

      child: BlocConsumer<AppCubit, AppStates>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState &&
              (currentState is AppThemeChangeState);
        },
        listener: (context, state) {
          if (state is AppThemeChangeState) {
            AppFunctions.showToast(message: state.message, color: AppColors.successColor,);
          }else if(state is AppLogoutUserSuccessState){
            AppFunctions.showToast(message: state.message, color: AppColors.successColor);
          }else if(state is AppLogoutErrorState){
            AppFunctions.showToast(message: state.errorMessage, color: AppColors.errorColor);
          }
        },
        builder: (context, states) {
          return MaterialApp(
            title: AppStrings.appTitle,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: AppCubit.get(context).themeMode,
            home: AppCubit.get(context).screenToNavigate(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
