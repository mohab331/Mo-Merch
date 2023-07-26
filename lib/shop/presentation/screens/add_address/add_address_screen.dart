import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({required this.addressCubit,Key? key,}) : super(key: key);
  static const String routeName = 'AddAddressScreen';
  static const String routePath = '/AddAddressScreen';
  final AddressCubit addressCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: addressCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('Add address',),),
        body: AddAddressContent(cubit: addressCubit),
      ),
    );
  }
}
