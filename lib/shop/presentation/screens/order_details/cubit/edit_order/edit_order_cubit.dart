import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/screens/order_details/cubit/index.dart';

class EditOrderCubit extends Cubit<EditOrderState>{
  EditOrderCubit({required this.editOrderUseCase,}):super(EditOrderInitialState());
  final EditOrderUseCase editOrderUseCase;

  void cancelOrder({required int orderId,})async{
    emit(EditOrderLoadingState());
    final response = await editOrderUseCase.call(orderId);
    response.fold((failure) {
      emit(EditOrderErrorState(message: failure.failureMessage,));
    }, (editOrderResponse) {
      emit(EditOrderSuccessState(message: editOrderResponse.message,));
    });
  }
}