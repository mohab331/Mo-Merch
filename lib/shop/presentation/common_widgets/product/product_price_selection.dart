import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

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
              '${product.price.toStringAsFixed(1)} \$',
              style: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.h),
            if (product.discount != 0)
              Text(
                '${product.oldPrice.toStringAsFixed(1)} \$',
                style: TextStyle(
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.bold,
                  color: R.colors.primaryColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        ),
        if(showDiscountPercent && product.discount != 0)
          Text('Discount: ${product.discount}%',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
      ],
    );
  }
}
