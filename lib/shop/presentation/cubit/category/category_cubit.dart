import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/category/get_category_products_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';

import '../shop/shop_cubit.dart';
import 'category_states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());
  static CategoryCubit get(context) => BlocProvider.of(context);



  List<Product> fetchedCategoryProducts = [];
  bool hasMoreProductsInCategoryDetails = true;
  int currentCategoryDetailsPage = 1;

  void emitChange() {
    emit(CategoryChangeScreen());
  }

  void getCategoryDetails(BuildContext context,
      {required int categoryId}) async {
    if (currentCategoryDetailsPage == 1) {
      fetchedCategoryProducts = [];
      hasMoreProductsInCategoryDetails = true;
    }
    if (hasMoreProductsInCategoryDetails == false) {
      return;
    }
    emit(CategoryDetailsLoadingDataState());
    String url = Endpoints.concatenateEndPoint(
        endPoint: Endpoints.categories, id: categoryId);
    final response = await di.sl<GetCategoryProductsUsecase>().call(
        GetUseCaseParameters(
            token: AppCubit.get(context).getUserToken(),
            url: url,
            page: currentCategoryDetailsPage));
    response.fold((failure) {
      emit(CategoryDetailsErrorDataState(message: failure.failureMessage));
    }, (categoryDetailsResponse) {
      if (categoryDetailsResponse
          .categoryDetailsResponseData.categoryProducts.isNotEmpty) {
        for (int i = 0;
            i <
                categoryDetailsResponse
                    .categoryDetailsResponseData.categoryProducts.length;
            i++) {
          fetchedCategoryProducts.add(categoryDetailsResponse
              .categoryDetailsResponseData.categoryProducts
              .elementAt(i));
          if (ShopCubit.get(context).favoriteProductsMap.containsKey(
                      categoryDetailsResponse
                          .categoryDetailsResponseData.categoryProducts
                          .elementAt(i)
                          .id) ==
                  false &&
              categoryDetailsResponse
                      .categoryDetailsResponseData.categoryProducts
                      .elementAt(i)
                      .inFavorites ==
                  true) {
            ShopCubit.get(context).favoriteProductsMap.addAll({
              categoryDetailsResponse
                      .categoryDetailsResponseData.categoryProducts
                      .elementAt(i)
                      .id:
                  categoryDetailsResponse
                      .categoryDetailsResponseData.categoryProducts
                      .elementAt(i)
            });
          }
          if (ShopCubit.get(context).productsInCartMap.containsKey(
                      categoryDetailsResponse
                          .categoryDetailsResponseData.categoryProducts
                          .elementAt(i)
                          .id) ==
                  false &&
              categoryDetailsResponse
                      .categoryDetailsResponseData.categoryProducts
                      .elementAt(i)
                      .inCart ==
                  true) {
            ShopCubit.get(context).productsInCartMap.addAll({
              categoryDetailsResponse
                      .categoryDetailsResponseData.categoryProducts
                      .elementAt(i)
                      .id:
                  categoryDetailsResponse
                      .categoryDetailsResponseData.categoryProducts
                      .elementAt(i)
            });
          }
        }
      }
      hasMoreProductsInCategoryDetails =
          categoryDetailsResponse.categoryDetailsResponseData.nextPageUrl !=
                  null
              ? true
              : false;
      currentCategoryDetailsPage =
          categoryDetailsResponse.categoryDetailsResponseData.currentPage;
      emit(CategoryDetailsSuccessDataState());
    });
  }
}
