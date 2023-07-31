import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductItemFooter extends StatelessWidget {
  const ProductItemFooter({
    required this.product,
    super.key,
  });

  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProductPriceSection(
          product: product,
        ),
        AnimatedProductFavoriteButton(
          product: product,
          showToastOnFavoriteToggle: true,
          iconSize: 25,
        ),
      ],
    );
  }
}
