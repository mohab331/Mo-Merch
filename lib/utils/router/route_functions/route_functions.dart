import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';

import 'package:shop_app_clean_architecture/utils/router/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

abstract class AppNavigation {
  void navigateToShopLayout({
    required Object? extras,
  });
  void navigateToRegisterScreen();
  void navigateToLoginScreen();
  void navigateToCategoryScreen();
  void navigateToCategoryProductsScreen({
    required Object extras,
  });
  void navigateToOnBoardingScreen();
  void navigateToProductDescriptionScreen({
    required ProductResponseEntity product,
    required FavoriteCubit favoriteCubit,
  });
  void navigateToChangePasswordScreen();
  void navigateToEditPersonalDataScreen({
    required Object extras,
  });
  void navigateToCartScreen();
  void navigateToProfileScreen();
  void navigateToFavoriteScreen();
}

class AppNavigationImpl implements AppNavigation {
  const AppNavigationImpl({
    required this.context,
  });
  final BuildContext context;
  @override
  void navigateToShopLayout({required Object? extras}) {
    context.goNamed(
      PostAuthRoutes.shopLayout.routeModel.name,
      extra: extras,
    );
  }

  @override
  void navigateToLoginScreen() {
    context.goNamed(
      PreAuthRoutes.login.routeModel.name,
    );
  }

  @override
  void navigateToRegisterScreen() {
    context.pushNamed(
      PreAuthRoutes.register.routeModel.name,
    );
  }

  @override
  void navigateToOnBoardingScreen() {
    context.goNamed(PreAuthRoutes.onBoarding.routeModel.name);
  }

  @override
  void navigateToCartScreen() {
    context.pushNamed(
      PostAuthRoutes.cart.routeModel.name,
    );
  }

  @override
  void navigateToProductDescriptionScreen({
    required ProductResponseEntity product,
    required FavoriteCubit favoriteCubit,
  }) {
    context.pushNamed(
      PostAuthRoutes.productDescription.routeModel.name,
      extra: {
        'product': product,
        'favoriteCubit': favoriteCubit,
      },
    );
  }

  @override
  void navigateToCategoryScreen() {
    context.pushNamed(
      PostAuthRoutes.category.routeModel.name,
    );
  }

  @override
  void navigateToCategoryProductsScreen({Object? extras}) {
    context.pushNamed(
      PostAuthRoutes.categoryProducts.routeModel.name,
      extra: extras,
    );
  }

  @override
  void navigateToProfileScreen() {
    context.pushNamed(
      PostAuthRoutes.profile.routeModel.name,
    );
  }

  @override
  void navigateToChangePasswordScreen() {
    context.pushNamed(
      PostAuthRoutes.changePassword.routeModel.name,
    );
  }

  @override
  void navigateToEditPersonalDataScreen({required Object extras}) {
    context.pushNamed(
      PostAuthRoutes.editPersonalData.routeModel.name,
      extra: extras,
    );
  }

  @override
  void navigateToFavoriteScreen() {
    context.pushNamed(
      PostAuthRoutes.favorite.routeModel.name,
    );
  }
}
