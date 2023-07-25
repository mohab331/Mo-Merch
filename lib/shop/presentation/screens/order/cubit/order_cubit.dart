import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/order/cubit/index.dart';

class OrderCubit extends Cubit<OrderState>{
  OrderCubit({required this.getOrderUsecase,}):super( OrderInitialState(),);
  final GetOrderUsecase getOrderUsecase;
  int currentPage = 1;
  bool hasMore = true;
  Map<int , OrderResponseEntity> ordersMap = {};

  void getOrders({required int page,})async{
    if(page == 1){
      hasMore = true;
      ordersMap.clear();
    }
    if(!hasMore){
      return;
    }
    emit(OrderLoadingState(),);
    final response = await getOrderUsecase.call(page,);
    response.fold((failure) {
      emit(OrderErrorState(message: failure.failureMessage,));
    }, (orderResponse){
      hasMore = orderResponse.nextPageUrl != null;
      currentPage = orderResponse.currentPage ?? 1;
      _addOrdersToMap(orderResponse.entityList);
      emit(OrderSuccessState(message: orderResponse.message,));
    });
  }

  void _addOrdersToMap(List<OrderResponseEntity> orders){
    for(int i = 0 ; i<orders.length ; i++){
      if(!ordersMap.containsKey(orders[i].id)){
        ordersMap.addAll({orders[i].id:orders[i]});
      }
    }
  }
}