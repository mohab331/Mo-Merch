import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_state.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/login/widgets/login_form.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              context.navigator.navigateToShopLayout();
            } else if (state is AuthenticationErrorState) {
              R.functions.showToast(
                message: state.message ?? 'Error Occurred While Logging In',
                color: state.toastColor ?? R.colors.redColor,
              );
            }else{}
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
