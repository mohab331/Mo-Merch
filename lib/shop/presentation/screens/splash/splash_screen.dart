import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'SplashScreen';
  static const String routePath = '/SplashScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => (diInstance.get<SplashCubit>()..getLocalData()),
      child: const Scaffold(
        body: SplashContent(),
      ),
    );
  }
}
