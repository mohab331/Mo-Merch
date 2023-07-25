import 'package:flutter/material.dart';

abstract class EditOrderState {
  const EditOrderState({
    this.message,
    this.toastColor,
  });
  final String? message;
  final Color? toastColor;
}

class EditOrderInitialState extends EditOrderState {}

class EditOrderErrorState extends EditOrderState {
  const EditOrderErrorState({
    super.message,
    super.toastColor = Colors.red,

  });
}

class EditOrderSuccessState extends EditOrderState {
  const EditOrderSuccessState({
    super.message,
    super.toastColor = Colors.green,
    this.cancelled = 'cancelled',
  });
final String cancelled;


}

class EditOrderLoadingState extends EditOrderState {}

class EditOrderInstantState extends EditOrderState {}
