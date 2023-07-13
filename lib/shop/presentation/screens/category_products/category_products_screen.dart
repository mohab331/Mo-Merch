import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/index.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({required this.category, Key? key})
      : super(key: key);
  final CategoryResponseEntity category;
  static const String routeName = 'CategoryProductsScreen';
  static const String routePath = '/CategoryProductsScreen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => diInstance.get<CategoryProductsCubit>()
        ..getCategoryProductsByID(
          page: 1,
          categoryId: category.id,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
        ),
        body: CategoryProductsContent(category: category,),
      ),
    );
  }
}
