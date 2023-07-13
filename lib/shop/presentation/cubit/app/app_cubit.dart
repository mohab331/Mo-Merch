import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.getFavoriteUsecase,
  }) : super(AppInitialState(),);
  Map<int, ProductResponseEntity> favoriteProductsMap = {};
  final GetFavoriteUsecase getFavoriteUsecase;
  void toggleAppTheme() {}

  void getFavoriteData({
    required int page,
  }) async {
    if(favoriteProductsMap.isNotEmpty){
      return;
    }
    emit(AppLoadingDataState());
    final response = await getFavoriteUsecase.call(
      page,
    );
    response.fold((error) {
      emit(AppErrorDataState(message: error.failureMessage,toastColor: Colors.red,));
    }, (favoriteResponse) {
      addProductsToFavoriteMap(
        favoriteResponse.entityList,
      );
      emit(AppSuccessDataState());
    });
  }

  void addProductsToFavoriteMap(List<FavoriteResponseEntity> items) {
    for (final favoriteItem in items) {
      addProductToMap(
        favoriteItem.product,
      );
    }
  }

  bool isInFavoriteMap({
    required int id,
  }) {
    return favoriteProductsMap.containsKey(
      id,
    );
  }

  void addProductToMap(ProductResponseEntity product) {
    if (!isInFavoriteMap(
      id: product.id,
    )) {
      favoriteProductsMap.addAll(
        {
          product.id: product,
        },
      );
    }
  }


  void addOrRemoveFavoriteFromMap({required ProductResponseEntity product}) {
    if (isInFavoriteMap(
      id: product.id,
    )) {
      removeProductFromFavoriteMap(product.id);
    } else {
      addProductToMap(
        product,
      );
    }
  }
  void removeProductFromFavoriteMap(int productId){
    favoriteProductsMap.remove(productId);
  }
}
