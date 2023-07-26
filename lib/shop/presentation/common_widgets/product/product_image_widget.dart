import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    required this.product,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        HeroCachedNetworkImage(
          id: product.id,
          imageHeight: 180,
          imageUrl: product.image,
        ),
        if (product.discount != 0) const DiscountBadge(),
      ],
    );
  }
}
