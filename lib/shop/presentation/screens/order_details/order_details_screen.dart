import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({required this.orderId, required this.editOrderCubit,Key? key}) : super(key: key);
  final int orderId;
  final EditOrderCubit editOrderCubit;
  static const String routeName = 'OrderDetailsScreen';
  static const String routePath = '/OrderDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(  create: (context) => diInstance.get<OrderDetailsCubit>()
      ..getOrderDetails(orderId: orderId),),
        BlocProvider.value(value: editOrderCubit,),
      ],

      child: Scaffold(
        backgroundColor: R.colors.lightGrey,
        appBar: AppBar(
          title: Text(
            orderId.toString(),
          ),
        ),
        body: OrderDetailsContent(
          orderId: orderId,
        ),
      ),
    );
  }
}
