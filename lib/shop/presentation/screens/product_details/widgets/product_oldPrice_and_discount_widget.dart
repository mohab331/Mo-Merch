import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';
class ProductOldPriceAndDiscountWidget extends StatelessWidget {
  const ProductOldPriceAndDiscountWidget({
    required this.productResponseEntity,
    Key? key,
  }) : super(key: key);

  final ProductResponseEntity productResponseEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextWithSpan(
              mainText: 'Old price: ',
              spanText: '${productResponseEntity.oldPrice.doubleToPrice()}',
              mainTextStyle: TextStyle(
                color: R.colors.blackColor,
                fontWeight: FontWeight.w500,
              ),
              spanTextStyle: TextStyle(
                color: R.colors.primaryColor,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const Spacer(),
            Text(
              'Discount: ${productResponseEntity.discount}%',
              style: TextStyle(
                color: R.colors.darkRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
