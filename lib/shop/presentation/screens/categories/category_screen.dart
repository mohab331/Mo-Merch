import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  static const String routeName = 'CategoryScreen';
  static const String routePath = '/CategoryScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<CategoryCubit>()
        ..getCategories(
          page: 1,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            R.strings.categories,
          ),
        ),
        body: const CategoryContent(),
      ),
    );
  }
}
