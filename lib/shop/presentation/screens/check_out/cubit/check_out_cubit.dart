import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CheckOutCubit extends Cubit<CheckOutState>{
  CheckOutCubit(
  {
    required this.addOrderUseCase,
}
      ):super(CheckOutInitialState());
  AddressResponseEntity? chosenAddress;
  final AddOrderUseCase addOrderUseCase;
  int index = 0;
  OrderResponseEntity? placedOrder;


  void toggleIndex(int value){
    if(index == 3 || index == -1) return;
    index = value;
    emit(ToggleBarIndex(index: index),);
  }

  void placeOrder({required CartCubit cartCubit,})async{
    if(chosenAddress == null) return;
    emit(PlaceOrderLoadingState());
    final response = await addOrderUseCase.call(AddOrderRequestEntity(addressId: chosenAddress!.id, paymentMethod: 1,));
    response.fold((failure) {
      emit(PlaceOrderErrorState(message: failure.failureMessage,));
    }, (placeOrderResponse) {
      cartCubit.clearCartItems();
      placedOrder =placeOrderResponse.entity;
      emit(PlaceOrderSuccessState(message: placeOrderResponse.message,),);

    });
  }
}