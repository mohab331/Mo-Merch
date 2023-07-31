import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';
class ProductNameAndPriceWidget extends StatelessWidget {
  const ProductNameAndPriceWidget({
    required this.productResponseEntity,
    Key? key,
  }) : super(key: key);

  final ProductResponseEntity productResponseEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 230.w,
          child: Text(
            productResponseEntity.name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: R.colors.primaryColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'EGP ${productResponseEntity.price.doubleToPrice()}',
            style: TextStyle(
              color: R.colors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

