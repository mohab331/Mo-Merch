import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/favorite/toggle_favorite_usecase.dart';

import '../../../domain/entities/home/home_response_entity.dart';
import '../../../domain/entities/product/product_response_entity.dart';
import '../app/app_cubit.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeResponse? homeResponse;


 void emitChange( ){
   emit(HomeInstantToggleIsFavoriteState());
 }

  void _instantToggle(BuildContext context , {required ProductResponseEntity product}){
    AppFunctions.updateFavoriteInScreens(context,product: product,);
    emit(HomeInstantToggleIsFavoriteState());
  }
  void _errorInToggle(BuildContext context , {required ProductResponseEntity product,}){
    AppFunctions.updateFavoriteInScreens(context,product: product,);
  }

  void toggleIsFavorite(BuildContext context,
      {required ProductResponseEntity product}) async{
    _instantToggle(context, product:product, );
    final response = await di.sl<ToggleFavoriteUsecase>().call(AddUseCaseParameters(data:{'product_id':product.id}, url: Endpoints.favorites,token: AppCubit.get(context).getUserToken(),));
    response.fold((failure){
      _errorInToggle(context, product: product, );
      emit(HomeToggleIsFavoriteErrorState(message: failure.failureMessage));
    }, (response){
      emit(
          HomeToggleIsFavoriteState(
            message: response['message'],
          )
      );
    });
  }


}


