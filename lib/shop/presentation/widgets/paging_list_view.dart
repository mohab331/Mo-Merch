import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/category_screen.dart';

class CategoryPagingListView extends StatelessWidget {
  const CategoryPagingListView({Key? key, required this.controller,required this.list,})
      : super(key: key);
  final ScrollController controller;
  final List list;
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(15.0),
          controller: controller,
          itemBuilder: (context, index) {
            return CategoryItem(categoryData: list.elementAt(index));
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: list.length,),
    );
  }
}
