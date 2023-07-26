import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const String routeName = 'FavoriteScreen';
  static const String routePath = '/FavoriteScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => diInstance.get<FavoriteCubit>()..getFavoriteData(context, page: 1,),
      child: Scaffold(
        backgroundColor: R.colors.lightGrey,
        body: const FavoriteContent(),
      ),
    );
  }
}

