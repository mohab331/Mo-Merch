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
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              context.navigator.navigateToShopLayout(extras: state.user,);
            }
            else if (state is AuthenticationErrorState) {
              R.functions.showToast(
                message:
                    state.errorMessage ?? 'Error Occurred While Registering',
                color: Colors.red,
              );
            }else{}
          },
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
