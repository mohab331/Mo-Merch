import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    required this.category,
    Key? key,
  }) : super(key: key);
  final CategoryResponseEntity category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> context.navigator.navigateToCategoryProductsScreen(extras: category,),
      child: Row(
        children: [
          CachedNetworkImageBuilder(
            imageUrl: category.image,
            width: 140.w,
            height: 120.h,
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              category.name.toUpperCase(),
              style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
