import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const String routeName = 'OrderScreen';
  static const String routePath = '/OrderScreen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>diInstance.get<OrderCubit>()..getOrders(page: 1),child: Scaffold(
      appBar: AppBar(title: const Text('Orders history'),),
      body: const OrderContent(),
    ),);
  }
}
