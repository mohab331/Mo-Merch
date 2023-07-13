import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class EditPersonalDataScreen extends StatelessWidget {
  const EditPersonalDataScreen({required this.user , Key? key }) : super(key: key);
    final UserResponseEntity user;
    static const String routeName = 'EditPersonalDataScreen';
    static const String routePath = '/EditPersonalDataScreen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<EditPersonalDataCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: EditPersonalDataContent(userData: user),
      ),
    );
  }
}
