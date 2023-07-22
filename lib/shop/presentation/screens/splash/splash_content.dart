import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) =>
          _handleNavigationAccordingToState(context, state),
      child: Center(child: Image.asset(R.images.moLogo)),
    );
  }

  void _handleNavigationAccordingToState(
    BuildContext context,
    SplashState state,
  ) {
    if (state is SplashSuccessState) {
      if (state.showOnBoarding == true) {
        context.navigator.navigateToOnBoardingScreen();
      } else if (!state.showOnBoarding && _isUserDataCached(state)) {
        context.read<AuthCubit>().setLoggedInUser(state.userDataResponseEntity);
        context.navigator.navigateToShopLayout();
      } else {
        context.navigator.navigateToLoginScreen();
      }
    }
  }

  bool _isUserDataCached(SplashSuccessState state) {
    return (state.userDataResponseEntity != null ||
        state.userDataResponseEntity?.token.isNotEmpty == true);
  }
}
