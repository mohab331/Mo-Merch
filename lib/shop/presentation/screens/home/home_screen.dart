import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/home/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'HomeScreen';
  static const String routePath = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<HomeCubit>()..getHomeData(),
      child: const HomeContent(),
    );
  }
}
