import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/router/index.dart';

abstract class AppNavigation {
  void navigateToShopLayout();

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

  void navigateToOrderScreen();

  void navigateToProfileScreen();

  void navigateToFavoriteScreen();

  void navigateToCheckOutScreen();
  void navigateToOrderDetailsScreen({
    required int orderId,
    required EditOrderCubit editOrderCubit,
  });
  void navigateToMapScreen(
      {double? initialLongitude,
      double? initialLatitude,
      Function(LocationInfo?)? onLocationSaved});

  void navigateToAddressScreen({
    required Function(AddressResponseEntity? chosenAddress) onAddressPressed,
  });
}

class AppNavigationImpl implements AppNavigation {
  const AppNavigationImpl({
    required this.context,
  });
  final BuildContext context;

  @override
  void navigateToShopLayout() {
    context.goNamed(
      PostAuthRoutes.shopLayout.routeModel.name,
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

  @override
  void navigateToCheckOutScreen() {
    context.pushNamed(
      PostAuthRoutes.checkOut.routeModel.name,
    );
  }

  @override
  void navigateToAddressScreen({
    required Function(AddressResponseEntity? chosenAddress) onAddressPressed,
  }) {
    context.pushNamed(
      PostAuthRoutes.address.routeModel.name,
      extra: onAddressPressed,
    );
  }

  @override
  void navigateToOrderScreen() {
    context.pushNamed(
      PostAuthRoutes.order.routeModel.name,
    );
  }

  @override
  void navigateToOrderDetailsScreen(
      {required int orderId, required EditOrderCubit editOrderCubit}) {
    context.pushNamed(
      PostAuthRoutes.orderDetails.routeModel.name,
      extra: {
        'orderId': orderId,
        'cubit': editOrderCubit,
      },
    );
  }

  @override
  void navigateToMapScreen({
    double? initialLongitude,
    double? initialLatitude,
    Function(LocationInfo?)? onLocationSaved,
  }) {
    context.pushNamed(
      PostAuthRoutes.map.routeModel.name,
      extra: {
        'initialLongitude': initialLongitude,
        'initialLatitude': initialLatitude,
        'onLocationSaved': onLocationSaved,
      },
    );
  }
}
