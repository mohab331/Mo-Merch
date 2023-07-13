import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String routeName = 'SearchScreen';
  static const String routePath = '/SearchScreen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<SearchCubit>(),
      child: const SearchContent(),
    );
  }
}
