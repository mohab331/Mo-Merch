import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/on_boarding/index.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  static const String routeName = 'OnBoardingScreen';
  static const String routePath = '/OnBoardingScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnBoardingCubit>(
      create: (context) => diInstance.get<OnBoardingCubit>(),
      child: const OnBoardingContent(),
    );
  }
}
