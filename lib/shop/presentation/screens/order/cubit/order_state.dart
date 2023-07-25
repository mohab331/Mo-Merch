import 'package:flutter/material.dart';

abstract class OrderState {
  const OrderState({
    this.message,
    this.toastColor,
  });
  final String? message;
  final Color? toastColor;
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {
  const OrderSuccessState({
    super.message,
    super.toastColor = Colors.green,
  });
}

class OrderErrorState extends OrderState {
  OrderErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}
