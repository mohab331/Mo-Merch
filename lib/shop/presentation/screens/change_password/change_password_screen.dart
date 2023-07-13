import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/index.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static const String routeName = 'ChangePasswordScreen';
  static const String routePath = '/ChangePasswordPath';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
        ),
        body:  ChangePasswordContent(),
      ),
    );
  }
}
