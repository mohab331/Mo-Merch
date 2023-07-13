import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/product/index.dart';

class ProductItemContent extends StatelessWidget {
  const ProductItemContent({
    required this.product,
    super.key,
  });
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImageWidget(
          product: product,
        ),
        SizedBox(
          height: 30.h,
        ),
        SizedBox(
          height: 45.h,
          child: Text(
            product.name,
            maxLines: 2,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
            ),
          ),
        ),
      ],
    );
  }
}
