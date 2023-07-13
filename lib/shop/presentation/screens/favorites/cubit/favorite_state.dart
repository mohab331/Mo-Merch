import 'package:flutter/material.dart';
abstract class FavoriteState {
  const FavoriteState({
    this.message,
    this.toastColor,
  });
  final String? message;
  final Color? toastColor;
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  const FavoriteSuccessState({
    super.message,
    super.toastColor = Colors.green,
  });
}

class FavoriteErrorState extends FavoriteState {
  const FavoriteErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}

class InstantToggleState extends FavoriteState{}

class FavoriteToggleLoadingState extends FavoriteState {}

class FavoriteToggleSuccessState extends FavoriteState {
  const FavoriteToggleSuccessState({
    super.message,
    super.toastColor = Colors.green,
  });

}

class FavoriteToggleErrorState extends FavoriteState {
  const FavoriteToggleErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}
