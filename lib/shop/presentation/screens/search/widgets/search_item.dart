import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({required this.product, Key? key}) : super(key: key);
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        height: 100.h,
        padding: const EdgeInsets.all(
          10.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20.0.r,
          ),
          border: Border.all(
            width: 2,
          ),
        ),
        child: Row(
          children: [
            HeroCachedNetworkImage(
              imageUrl: product.image,
              id: product.id,
              imageHeight: 100,
              imageWidth: 90,
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    '${product.price.toStringAsFixed(1)} \$',
                    style: TextStyle(
                      color: R.colors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
