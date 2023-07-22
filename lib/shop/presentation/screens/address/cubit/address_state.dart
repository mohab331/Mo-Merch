import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class AddressState {
  const AddressState({
    this.toastColor,
    this.message,
  });

  final String? message;
  final Color? toastColor;
}

class AddressInitialState extends AddressState {}

class GetAddressLoadingState extends AddressState {}

class GetAddressErrorState extends AddressState {
  const GetAddressErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}

class GetAddressSuccessState extends AddressState {
  const GetAddressSuccessState({
    required this.addressResponse,
  });

  final List<AddressResponseEntity> addressResponse;
}

class AddAddressLoadingState extends AddressState {}

class AddAddressErrorState extends AddressState {
  const AddAddressErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}

class AddAddressSuccessState extends AddressState {
  AddAddressSuccessState({
    required this.addressResponse,
    super.message,
    super.toastColor = Colors.green,
  });

  final List<AddressResponseEntity> addressResponse;
}
