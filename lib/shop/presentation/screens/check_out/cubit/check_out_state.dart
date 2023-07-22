import 'package:flutter/material.dart';


abstract class CheckOutState {
  const CheckOutState({this.message, this.toastColor});
  final String? message;
  final Color? toastColor;
}

class CheckOutInitialState extends CheckOutState {}

class ToggleBarIndex extends CheckOutState {
  const ToggleBarIndex({
    required this.index,
  });
  final int index;
}

class PlaceOrderLoadingState extends CheckOutState {}

class PlaceOrderSuccessState extends CheckOutState {
  const PlaceOrderSuccessState({
    super.message,
    super.toastColor = Colors.green,
  });
}

class PlaceOrderErrorState extends CheckOutState {
  const PlaceOrderErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}
