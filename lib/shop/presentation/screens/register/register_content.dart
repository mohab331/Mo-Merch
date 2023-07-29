import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class RegisterContent extends HookWidget {
  const RegisterContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    return WillPopScope(
      onWillPop: (){
        if(authState is AuthenticationLoadingState) return Future.value(false);
        return Future.value(true);
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthenticatedState) {
                context.navigator.navigateToShopLayout();
              }
              else if (state is AuthenticationErrorState) {
                R.functions.showToast(
                  message: state.message ?? 'Error Occurred While Registering',
                  color: R.colors.redColor,
                );
              }else{}
            },
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}
