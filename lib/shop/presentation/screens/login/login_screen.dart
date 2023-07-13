import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = 'LoginScreen';
  static const String routePath = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: const LoginContent(),
      ),
    );
  }
}
