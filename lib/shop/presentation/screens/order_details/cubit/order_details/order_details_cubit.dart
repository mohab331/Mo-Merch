import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/order_details/cubit/order_details/index.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({
    required this.getOrderDetailsUsecase,
  }) : super(OrderDetailsInitialState());

  final GetOrderDetailsUsecase getOrderDetailsUsecase;

  void getOrderDetails({required int orderId}) async {
    emit(OrderDetailsLoadingState());
    final response = await getOrderDetailsUsecase.call(
      OrderDetailsRequestEntity(
        orderId: orderId,
      ),
    );
    response.fold((failure) {
      emit(OrderDetailsErrorState(
        message: failure.failureMessage,
      ));
    }, (orderDetailsResponse) {
      emit(
        OrderDetailsSuccessState(
          orderDetails: orderDetailsResponse.entity,
          message: orderDetailsResponse.message,
        ),
      );
    });
  }
}
