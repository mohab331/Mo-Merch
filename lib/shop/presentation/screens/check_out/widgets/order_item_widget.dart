import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';
class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    required this.itemInCart,
    super.key,
  });
  final CartItem itemInCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              itemInCart.product.name,
              style: TextStyle(fontSize: 16.sp),
            ),
            leading: CachedNetworkImageBuilder(
              imageUrl: itemInCart.product.image,
              height: 200,
              width: 100,
            ),
            subtitle: Text(
              '${itemInCart.quantity} X ${itemInCart.product.price.doubleToPrice()} = ${(itemInCart.product.price * itemInCart.quantity).doubleToPrice()} \$',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }
}
