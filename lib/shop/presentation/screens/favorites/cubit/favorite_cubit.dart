import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';


class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    required this.getFavoriteUsecase,
    required this.toggleFavoriteUsecase,
  }) : super(
          FavoriteInitialState(),
        );
  final GetFavoriteUsecase getFavoriteUsecase;
  final ToggleFavoriteUsecase toggleFavoriteUsecase;

  bool hasMoreData = true;
  int currentPage = 1;


  void getFavoriteData(BuildContext context,{
    required int page,
  }) async {
    if(page == 1){
      hasMoreData = true;
      context.read<AppCubit>().favoriteProductsMap = {};
    }
    if (!hasMoreData) {
      return;
    }
    emit(
      FavoriteLoadingState(),
    );
    final response = await getFavoriteUsecase.call(
      page,
    );
    response.fold((failure) {
      emit(
        FavoriteErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (favoriteResponse) {
      context.read<AppCubit>().addProductsToFavoriteMap(
        favoriteResponse.entityList,
      );
      hasMoreData = favoriteResponse.nextPageUrl != null;
      currentPage = favoriteResponse.currentPage ?? 1;
      emit(
        FavoriteSuccessState(
          message: favoriteResponse.message,
        ),
      );
    });
  }

  void toggleFavorite(AppCubit appCubit,{
    required ProductResponseEntity product,
  }) async {
    _instantToggle(appCubit,product);
    final response = await toggleFavoriteUsecase.call(
      FavoriteRequestEntity(
        productId: product.id,
      ),
    );
    response.fold(
      (failure) {
        appCubit.addOrRemoveFavoriteFromMap(product: product);
        emit(
          FavoriteToggleErrorState(
            message: failure.failureMessage,
          ),
        );
      },
      (toggleFavoriteResponse) {
        emit(
          FavoriteToggleSuccessState(
            message: toggleFavoriteResponse.message,
          ),
        );
      },
    );
  }


  void _instantToggle(AppCubit appCubit,ProductResponseEntity product) {
    emit(
      InstantToggleState(),
    );
    appCubit.addOrRemoveFavoriteFromMap(product: product);
  }

}
