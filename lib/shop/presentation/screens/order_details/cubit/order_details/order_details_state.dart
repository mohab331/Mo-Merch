import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';

abstract class OrderDetailsState {
  const OrderDetailsState({
    this.message,
    this.toastColor,
  });
  final String? message;
  final Color? toastColor;
}

class OrderDetailsInitialState extends OrderDetailsState {}

class OrderDetailsSuccessState extends OrderDetailsState {
  const OrderDetailsSuccessState({
    required this.orderDetails,
    super.message,
    super.toastColor = Colors.green,
  });
  final OrderDetailsResponseEntity orderDetails;
}

class OrderDetailsErrorState extends OrderDetailsState {
  const OrderDetailsErrorState({

    super.message,
    super.toastColor = Colors.red,
  });

}

class OrderDetailsLoadingState extends OrderDetailsState {}
