// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app_clean_architecture/core/api/end_points.dart';
// import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
// import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
// import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';
// import 'package:shop_app_clean_architecture/shop/domain/usecases/order/get_order_details_usecase.dart';
// import 'package:shop_app_clean_architecture/shop/domain/usecases/order/get_order_usecase.dart';
// import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
//
// import 'order_states.dart';
//
//
//
// class OrderCubit extends Cubit<OrderStates>{
//   OrderCubit():super(OrderInitialState());
//   static OrderCubit get(context)=>BlocProvider.of(context);
//
//   List<GetOrderResponseDataItem> fetchedOrders = [];
//   bool hasMoreOrdersData = true;
//   int currentOrderPage = 1;
//
//   OrderDetailsResponseData? orderDetails;
//
//   void getOrders(BuildContext context ,) async{
//     if(currentOrderPage == 1){
//       fetchedOrders = [];
//       hasMoreOrdersData = true;
//     }
//     if(hasMoreOrdersData == false){
//       return;
//     }
//     emit(OrderGetDataLoadingState());
//     final response = await di.sl<GetOrderUsecase>().call(GetUseCaseParameters(token: AppCubit.get(context).getUserToken(), url: Endpoints.orders,page: currentOrderPage));
//     response.fold((failure){
//       emit(OrderGetDataErrorState(errorMessage: failure.failureMessage));
//     }, (getOrderResponse){
//       fetchedOrders.addAll(getOrderResponse.getOrderResponseData.orders);
//       currentOrderPage = getOrderResponse.getOrderResponseData.currentPage;
//       hasMoreOrdersData = getOrderResponse.getOrderResponseData.nextPageUrl != null ? true:false;
//       emit(OrderGetDataSuccessState());
//     });
//   }
//   void getOrderDetails(BuildContext context,{required int orderId}) async{
//     emit(OrderGetDetailsDataLoadingState());
//     String url = Endpoints.concatenateEndPoint(endPoint: Endpoints.orders, id: orderId);
//     final response = await di.sl<GetOrderDetailsUsecase>().call(GetUseCaseParameters(token: AppCubit.get(context).getUserToken(), url: url,));
//     response.fold((failure){
//       emit(OrderGetDetailsDataErrorState(errorMessage: failure.failureMessage));
//     }, (orderDetailsResponse) {
//       orderDetails = orderDetailsResponse.orderDetailsResponseData;
//       emit(OrderGetDetailsDataSuccessState());
//     });
//   }
// }