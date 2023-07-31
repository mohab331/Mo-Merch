import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class ProductPriceSection extends StatelessWidget {
  const ProductPriceSection({
    required this.product,
    this.showDiscountPercent = false,
    super.key,
  });
  final ProductResponseEntity product;
  final bool showDiscountPercent;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EGP ${product.price.doubleToPrice()}',
              style: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.h),
            if (product.discount != 0)
              Text(
                'EGP ${product.oldPrice.doubleToPrice()}',
                style: TextStyle(
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.bold,
                  color: R.colors.primaryColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        ),
        if (showDiscountPercent && product.discount != 0)
          Text(
            'Discount: ${product.discount}%',
            style: TextStyle(
              color: R.colors.redColor,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
