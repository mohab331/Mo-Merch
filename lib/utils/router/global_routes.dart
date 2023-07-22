import 'package:flutter/foundation.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

enum PreAuthRoutes {
  onBoarding(
    RouteModel(
      name: OnBoardingScreen.routeName,
      path: OnBoardingScreen.routePath,
    ),
  ),
  splash(
    RouteModel(
      name: SplashScreen.routeName,
      path: SplashScreen.routePath,
    ),
  ),
  login(
    RouteModel(
      name: LoginScreen.routeName,
      path: LoginScreen.routePath,
    ),
  ),
  register(
    RouteModel(
      name: RegisterScreen.routeName,
      path: RegisterScreen.routePath,
    ),
  );

  const PreAuthRoutes(this.routeModel);
  final RouteModel routeModel;

  static bool isInPreAuthRoute(String path) {
    try {
      PreAuthRoutes.values.firstWhere(
        (element) => element.routeModel.path == path,
      );
      return true;
    } on StateError catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

enum PostAuthRoutes {
  shopLayout(
    RouteModel(
      name: ShopLayout.routeName,
      path: ShopLayout.routePath,
    ),
  ),
  home(
    RouteModel(
      name: HomeScreen.routeName,
      path: HomeScreen.routePath,
    ),
  ),
  category(
    RouteModel(
      name: CategoryScreen.routeName,
      path: CategoryScreen.routePath,
    ),
  ),
  categoryProducts(
    RouteModel(
      name: CategoryProductsScreen.routeName,
      path: CategoryProductsScreen.routePath,
    ),
  ),
  search(
    RouteModel(
      name: SearchScreen.routeName,
      path: SearchScreen.routePath,
    ),
  ),
  cart(
    RouteModel(
      name: CartScreen.routeName,
      path: CartScreen.routePath,
    ),
  ),
  checkOut(
    RouteModel(
      name: CheckOutScreen.routeName,
      path: CheckOutScreen.routePath,
    ),
  ),
  address(
    RouteModel(
      name: AddressScreen.routeName,
      path: AddressScreen.routePath,
    ),
  ),
  profile(
    RouteModel(
      name: ProfileScreen.routeName,
      path: ProfileScreen.routePath,
    ),
  ),
  changePassword(
    RouteModel(
      name: ChangePasswordScreen.routeName,
      path: ChangePasswordScreen.routePath,
    ),
  ),
  editPersonalData(
    RouteModel(
      name: EditPersonalDataScreen.routeName,
      path: EditPersonalDataScreen.routePath,
    ),
  ),
  favorite(
    RouteModel(
      name: FavoriteScreen.routeName,
      path: FavoriteScreen.routePath,
    ),
  ),
  productDescription(
    RouteModel(
      name: ProductDetailsScreen.routeName,
      path: ProductDetailsScreen.routePath,
    ),

  );

  const PostAuthRoutes(this.routeModel);
  final RouteModel routeModel;

  static bool isInPostAuthRoute(String path) {
    try {
      PostAuthRoutes.values.firstWhere(
        (element) => element.routeModel.path == path,
      );
      return true;
    } on StateError catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

class RouteModel {
  const RouteModel({required this.name, required this.path});
  final String name;
  final String path;
}
