import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';


class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);
  static const String routeName = 'CheckOutScreen';
  static const String routePath = '/CheckOutScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<CheckOutCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: CheckOutContent(
          cartItems: context.read<CartCubit>().cartItems.values.toList(),
        ),
      ),
    );
  }
}
