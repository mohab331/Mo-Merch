import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/core/index.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({
    required this.productDescription,
    Key? key,
  }) : super(key: key);
  final String? productDescription;
  @override
  Widget build(BuildContext context) {
    return productDescription == null
        ? Container()
        : ExpansionTile(
            title: Text(
              R.strings.productDescription,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            iconColor: Theme.of(context).iconTheme.color,
            collapsedIconColor: Theme.of(context).iconTheme.color,
            subtitle: Text(R.strings.clickToExpand,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                )),
            trailing: const Icon(
              Icons.expand_circle_down_outlined,
            ),
            childrenPadding: const EdgeInsets.all(
              15.0,
            ),
            children: [
              Text(
                productDescription ?? '',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent),
                textAlign: TextAlign.left,
              ),
            ],
          );
  }
}
