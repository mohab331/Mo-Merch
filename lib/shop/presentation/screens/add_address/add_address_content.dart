import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
class AddAddressContent extends StatelessWidget {
  const AddAddressContent({required this.cubit , Key? key}) : super(key: key);
  final AddressCubit cubit;
  @override
  Widget build(BuildContext context) {
    return AddAddressWidget(addressCubit: context.read<AddressCubit>(),);
  }
}
