import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/order/add_order_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/cart/cart_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';

import 'check_out_states.dart';


class CheckOutCubit extends Cubit<CheckOutStates> {
 
  CheckOutCubit() : super(CheckOutInitialState());
  static CheckOutCubit get(context) => BlocProvider.of(context);

  int index = 1;
  int? addressId;

  void toggleIndex({required int currentIndex}) {
    index = currentIndex;
    emit(CheckOutToggleState());
  }

  void createOrder(BuildContext context,)async{
    emit(CheckOutLoadingState());
    final response = await di.sl<AddOrderUseCase>().call(AddUseCaseParameters(data:{'address_id':addressId , 'payment_method':1 , 'use_points':false} , url: Endpoints.orders,token: AppCubit.get(context).getUserToken()));
    response.fold((failure){
      emit(CheckOutErrorState(error: failure.failureMessage));
    }, (orderResponse){
      _emptyCart(context);
      index += 1;
      emit(CheckOutSuccessState(message: orderResponse.message));
    });

  }
  void _emptyCart(BuildContext context){
    ShopCubit.get(context).productsInCartMap = {};
    if(Provider.of<CartCubit?>(context,listen: false) != null){
      CartCubit.get(context).cartMap = {};
      CartCubit.get(context).cartTotal = 0.0;
      CartCubit.get(context).cartSubtotal = 0.0;
      CartCubit.get(context).cartVat = 0.0;
    }
    CartCubit.get(context).cartMap = {};
  }

}
