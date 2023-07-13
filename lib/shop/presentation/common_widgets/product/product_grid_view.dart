import 'package:flutter/material.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/product/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({required this.products,
    this.isScrollable = false,
    this.controller,
    super.key,});

  final List<ProductResponseEntity> products;
  final ScrollController? controller;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: isScrollable
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.53,
      ),
      itemBuilder: (context, index) {
            return ProductItemBuilder(
              product: products[index],
            );
      },
      itemCount: products.length,
    );
  }
}
