import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/product/product_response_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/add_to_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/favorite/toggle_favorite_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/favorite/favorite_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/home/home_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/product_description/product_description_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';

class ProductDescriptionCubit extends Cubit<ProductDescriptionStates> {
  ProductDescriptionCubit() : super(ProductDescriptionInitialState());

  static ProductDescriptionCubit get(context) => BlocProvider.of(context);

  void addOrRemoveProductFromCart(BuildContext context,
      {required ProductResponseEntity product}) async {
    emit(ProductDescriptionLoadingAddState());
    final response = await di.sl<AddToCartUseCase>().call(AddUseCaseParameters(
        data: {'product_id': product.id},
        url: Endpoints.carts,
        token: AppCubit.get(context).getUserToken()));
    response.fold((failure) {
      emit(
        ProductDescriptionAddOrRemoveProductFromCartErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (cartResponse) {
      AppFunctions.updateCartInMap(context, product: product);
      emit(
        ProductDescriptionAddOrRemoveProductFromCartSuccessState(
          message: cartResponse,
        ),
      );
    });
  }
  String toggleButtonLabel(BuildContext context, {required int productId}) {
    if (ShopCubit.get(context).productsInCartMap.containsKey(productId)) {
      return AppStrings.removeFromCart;
    } else {
      return AppStrings.addToCart;
    }
  }
  void _updateScreens(BuildContext context, {required ProductResponseEntity product}) {
    if (Provider.of<ShopCubit?>(context, listen: false) != null) {
      if (ShopCubit.get(context).homeProductsMap.containsKey(product.id)) {
        if (Provider.of<HomeCubit?>(context, listen: false) != null) {
          HomeCubit.get(context).emitChange();
        }else if(Provider.of<FavoriteCubit?>(context,listen: false) == null){
          ShopCubit.get(context).changeScreen();
        }
      }
    }
    if (Provider.of<FavoriteCubit?>(context, listen: false) != null) {
      if (FavoriteCubit.get(context)
              .favoriteProducts
              .indexWhere((element) => element.id == product.id) !=
          -1) {
        FavoriteCubit.get(context).favoriteProducts.remove(product);
        FavoriteCubit.get(context).emitChange();
      }
    }
  }
  void toggleAddToFavorite(BuildContext context,
      {required ProductResponseEntity product}) async {
    AppFunctions.updateFavoriteInScreens(
      context,
      product: product,
    );
    _updateScreens(context, product: product);
    emit(ProductDescriptionToggleFavoritesInstantState());
    final response = await di.sl<ToggleFavoriteUsecase>().call(
        AddUseCaseParameters(
            data: {'product_id': product.id},
            url: Endpoints.favorites,
            token: AppCubit.get(context).getUserToken()));
    response.fold((failure) {
      AppFunctions.updateFavoriteInScreens(
        context,
        product: product,
      );
      _updateScreens(context, product: product);
      try {
        emit(ProductDescriptionErrorState(
          message: failure.failureMessage,
        ));
      } on StateError catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }, (responseMap) {
      try {
        emit(ProductDescriptionToggleFavoritesState(
            message: responseMap['message']));
      } on StateError catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
  }
}
