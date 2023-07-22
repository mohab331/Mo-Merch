import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({
    required this.onLongPressed,
    Key? key,
  }) : super(key: key);
  final Function(AddressResponseEntity? chosenAddress) onLongPressed;
  static const String routeName = 'AddressScreen';
  static const String routePath = '/AddressScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          diInstance.get<AddressCubit>()..getUserAddresses(page: 1),
      child: AddressContent(
        onLongPressed: onLongPressed,
      ),
    );
  }
}
