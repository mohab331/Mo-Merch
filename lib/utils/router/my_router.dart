import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/router/global_routes.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    initialLocation: PreAuthRoutes.splash.routeModel.path,
    routes: [
      ..._preAuthRoutes,
      ..._postAuthRoute,
    ],
    errorPageBuilder: (context, state) {
      if (kDebugMode) {
        print(state.error.toString());
      }
      return MaterialPage(
        key: state.pageKey,
        //Todo implement error screen
        child: Container(),
      );
    },
    redirect: (context, state) {
      if (context.read<AuthCubit>() is UnAuthenticatedState) {
        return PreAuthRoutes.login.routeModel.path;
      }
      return null;
    },
    debugLogDiagnostics: true,
  );

  static final _preAuthRoutes = [
    GoRoute(
      path: PreAuthRoutes.splash.routeModel.path,
      name: PreAuthRoutes.splash.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const SplashScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PreAuthRoutes.onBoarding.routeModel.path,
      name: PreAuthRoutes.onBoarding.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const OnBoardingScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PreAuthRoutes.login.routeModel.path,
      name: PreAuthRoutes.login.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const LoginScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PreAuthRoutes.register.routeModel.path,
      name: PreAuthRoutes.register.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const RegisterScreen(),
          key: state.pageKey,
        );
      },
    ),
  ];

  static final _postAuthRoute = [
    GoRoute(
      path: PostAuthRoutes.home.routeModel.path,
      name: PostAuthRoutes.home.routeModel.name,
      pageBuilder: (context, state) => MaterialPage(
        child: const HomeScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: PostAuthRoutes.shopLayout.routeModel.path,
      name: PostAuthRoutes.shopLayout.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: ShopLayout(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.category.routeModel.path,
      name: PostAuthRoutes.category.routeModel.name,
      pageBuilder: (context, state) => MaterialPage(
        child: const CategoryScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: PostAuthRoutes.favorite.routeModel.path,
      name: PostAuthRoutes.favorite.routeModel.name,
      pageBuilder: (context, state) => MaterialPage(
        child: const FavoriteScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: PostAuthRoutes.categoryProducts.routeModel.path,
      name: PostAuthRoutes.categoryProducts.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as CategoryResponseEntity;
        return MaterialPage(
          child: CategoryProductsScreen(
            category: extra,
          ),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.productDescription.routeModel.path,
      name: PostAuthRoutes.productDescription.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return MaterialPage(
          child: ProductDetailsScreen(
            product: extra['product'],
            favoriteCubit: extra['favoriteCubit'],
            showToastOnFavoriteToggle: extra['showToastOnFavoriteToggle'],
          ),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.cart.routeModel.path,
      name: PostAuthRoutes.cart.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const CartScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.checkOut.routeModel.path,
      name: PostAuthRoutes.checkOut.routeModel.name,
      pageBuilder: (context, state) => MaterialPage(
        child: const CheckOutScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: PostAuthRoutes.address.routeModel.path,
      name: PostAuthRoutes.address.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Function(AddressResponseEntity?);
        return MaterialPage(
          child: AddressScreen(onLongPressed: extra),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.addAddress.routeModel.path,
      name: PostAuthRoutes.addAddress.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as AddressCubit;
        return MaterialPage(
          child: AddAddressScreen(
            addressCubit: extra,
          ),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.search.routeModel.path,
      name: PostAuthRoutes.search.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const SearchScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.changePassword.routeModel.path,
      name: PostAuthRoutes.changePassword.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const ChangePasswordScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.editPersonalData.routeModel.path,
      name: PostAuthRoutes.editPersonalData.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as UserResponseEntity;
        return MaterialPage(
          child: EditPersonalDataScreen(
            user: extra,
          ),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.profile.routeModel.path,
      name: PostAuthRoutes.profile.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const ProfileScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.order.routeModel.path,
      name: PostAuthRoutes.order.routeModel.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const OrderScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.orderDetails.routeModel.path,
      name: PostAuthRoutes.orderDetails.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return MaterialPage(
          child: OrderDetailsScreen(
            orderId: extra['orderId'],
            editOrderCubit: extra['cubit'],
          ),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: PostAuthRoutes.map.routeModel.path,
      name: PostAuthRoutes.map.routeModel.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return MaterialPage(
          child: MapsScreen(
            initialLatitude: extra?['initialLatitude'],
            initialLongitude: extra?['initialLongitude'],
            onLocationSaved: extra?['onLocationSaved'],
          ),
          key: state.pageKey,
        );
      },
    ),
  ];
}
