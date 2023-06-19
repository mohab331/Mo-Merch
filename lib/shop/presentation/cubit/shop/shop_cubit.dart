import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;

import 'package:shop_app_clean_architecture/shop/domain/entities/product/product_response_model.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/favorite/favorite_cubit.dart';

import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_states.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/home/home_response_model.dart';
import '../../../domain/usecases/category/get_category_usecase.dart';
import '../../../domain/usecases/home/get_home_usecase.dart';
import '../../screens/category_screen.dart';
import '../../screens/favorite_screen.dart';
import '../../screens/home_screen.dart';
import '../app/app_cubit.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List navBarScreens = [
    const HomeScreen(),
    const CategoryScreen(),
    BlocProvider(
        create: (context) => di.sl<FavoriteCubit>()..getFavoriteData(context),
        child: const FavoriteScreen()),
  ];

  Map<int, String> favoriteProductsMap = {};
  Map<int, String> productsInCartMap = {};
  Map<int, ProductResponseEntity> homeProductsMap = {};
  List<Banners> banners = [];

  List<CategoryData> fetchedCategories = [];
  bool hasMoreCategories = true;
  int currentCategoryPage = 1;

  void changeScreen() {
    emit(GetHomeDataSuccessState());
  }

  void toggleNavBarCurrentIndex(int index) {
    currentIndex = index;
    emit(ShopToggleNavBarState());
  }

  void getHomeData(BuildContext context) async {
    if (homeProductsMap.isNotEmpty) {
      return;
    }
    emit(GetHomeDataLoadingState());

    final response = await di.sl<GetHomeUsecase>().call(GetUseCaseParameters(
          token: AppCubit.get(context).getUserToken(),
          url: Endpoints.home,
        ));
    response.fold((failure) {
      emit(GetHomeDataErrorState(errorMessage: failure.failureMessage));
    }, (homeResponse) {
      banners.addAll(homeResponse.homeData.banners);
      // putting data in maps
      for (int i = 0; i < homeResponse.homeData.products.length; i++) {
        homeProductsMap.addAll({
          homeResponse.homeData.products.elementAt(i).id:
              homeResponse.homeData.products.elementAt(i)
        });
        if (homeResponse.homeData.products.elementAt(i).inFavorites == true) {
          favoriteProductsMap.addAll({
            homeResponse.homeData.products.elementAt(i).id:
                homeResponse.homeData.products.elementAt(i).name
          });
        }
        if (homeResponse.homeData.products.elementAt(i).inCart == true) {
          productsInCartMap.addAll({
            homeResponse.homeData.products.elementAt(i).id:
                homeResponse.homeData.products.elementAt(i).name
          });
        }
      }
      emit(GetHomeDataSuccessState());
    });
  }

  void getCategories(BuildContext context, {bool fromReload = false}) async {
    if (currentCategoryPage == 1 &&
        !fromReload &&
        fetchedCategories.isNotEmpty) {
      return;
    }
    if (currentCategoryPage == 1) {
      fetchedCategories = [];
      hasMoreCategories = true;
    }
    if (hasMoreCategories == false) {
      return;
    }
    emit(GetCategoryDataLoadingState());
    final response =
        await di.sl<GetCategoryUsecase>().call(GetUseCaseParameters(
              token: AppCubit.get(context).getUserToken(),
              url: Endpoints.categories,
              page: currentCategoryPage,
            ));
    response.fold((failure) {
      emit(GetCategoryDataErrorState(errorMessage: failure.failureMessage));
    }, (categoryResponse) {
      fetchedCategories
          .addAll(categoryResponse.categoryResponseData.categories);
      hasMoreCategories =
          categoryResponse.categoryResponseData.nextPageUrl != null
              ? true
              : false;
      currentCategoryPage = categoryResponse.categoryResponseData.currentPage;
      emit(GetCategoryDataSuccessState());
    });
  }
}
