import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/core/utils/functions.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/favorite/get_favorite_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/favorite/toggle_favorite_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';

import '../../../domain/entities/product/product_response_model.dart';
import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  List<ProductResponseEntity> favoriteProducts = [];
  bool hasMoreFavoriteData = true;
  int currentFavoritePage = 1;
  void emitChange() {
    emit(FavoriteChangeScreenState());
  }

  void getFavoriteData(
    BuildContext context,
  ) async {
    ShopCubit.get(context).favoriteProductsMap = {};
    if (currentFavoritePage == 1) {
      favoriteProducts = [];
      hasMoreFavoriteData = true;
    }
    if (hasMoreFavoriteData == false) {
      return;
    }
    emit(FavoriteLoadingDataState());
    final response = await di.sl<GetFavoriteUsecase>().call(
          GetUseCaseParameters(
            token: AppCubit.get(context).getUserToken(),
            url: Endpoints.favorites,
            page: currentFavoritePage,
          ),
        );
    response.fold((failure) {
      emit(FavoriteErrorDataState(errorMessage: failure.failureMessage));
    }, (favoriteResponse) {
      for (int i = 0; i < favoriteResponse.data.favoriteProducts.length; i++) {
        favoriteProducts
            .add(favoriteResponse.data.favoriteProducts.elementAt(i));
        ShopCubit.get(context).favoriteProductsMap.addAll({
          favoriteResponse.data.favoriteProducts.elementAt(i).id:
              favoriteResponse.data.favoriteProducts.elementAt(i).name
        });
      }
      currentFavoritePage = favoriteResponse.data.currentPage;
      hasMoreFavoriteData =
          favoriteResponse.data.nextPageUrl != null ? true : false;
      emit(FavoriteSuccessDataState());
    });
  }

  void removeFromFavorites(BuildContext context,
      {required ProductResponseEntity product}) async {
    _instantRemoveFromFavorite(context, product: product);

    final response = await di.sl<ToggleFavoriteUsecase>().call(
        AddUseCaseParameters(
            data: {'product_id': product.id},
            url: Endpoints.favorites,
            token: AppCubit.get(context).getUserToken()));
    response.fold((failure) {
      _errorInRemoveFavorite(context,
          product: product, errorMessage: failure.failureMessage);
    }, (response) {
      try {
        emit(FavoriteDeleteItemSuccessState(message: response['message']));
      } on StateError catch (_) {
        // TODO
      }
    });
  }

  void _instantRemoveFromFavorite(BuildContext context,
      {required ProductResponseEntity product}) {
    favoriteProducts.removeWhere((element) => element.id == product.id);
    AppFunctions.updateFavoriteInScreens(context, product: product);
    try {
      emit(FavoriteDeleteItemInstantState());
    } on StateError catch (_) {
      // TODO
    }
  }

  void _errorInRemoveFavorite(BuildContext context,
      {required ProductResponseEntity product, required String errorMessage}) {
    favoriteProducts.add(product);
    AppFunctions.updateFavoriteInScreens(context, product: product);
    emit(FavoriteErrorDataState(errorMessage: errorMessage));
  }
}
