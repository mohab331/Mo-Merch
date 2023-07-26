import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderProductsWidget extends StatelessWidget {
  const OrderProductsWidget({
    required this.orderProducts,
    Key? key,
  }) : super(key: key);

  final List<ProductOrderResponseEntity> orderProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirmed (${orderProducts.length} item(s) )',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: orderProducts.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return OrderProductItem(product: orderProducts[index]);
          },
        ),
      ],
    );
  }
}

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({required this.product, Key? key}) : super(key: key);

  final ProductOrderResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductImageWidget(productOrder: product,),
          SizedBox(width: 13.w),
          OrderProductDetailsWidget(product: product),
        ],
      ),
    );
  }
}

class OrderProductImageWidget extends StatelessWidget {
  const OrderProductImageWidget({required this.productOrder, Key? key}) : super(key: key);
  final ProductOrderResponseEntity productOrder;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: R.colors.greyColor,
            ),
          ),
          child: CachedNetworkImageBuilder(
            imageUrl: productOrder.image,
            height: 150.h,
            width: 90.w,
          ),
        ),
        Card(
          elevation: 5.0,
          color: R.colors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'x ${productOrder.quantity}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class OrderProductDetailsWidget extends StatelessWidget {
  const OrderProductDetailsWidget({required this.product, Key? key,}) : super(key: key);

  final ProductOrderResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200.w,
            child: Text(
              product.name,
            ),
          ),
          SizedBox(height: 15.h),
          TextWithSpan(
            mainText: 'EGP',
            spanText: ' ${product.price.doubleToPrice()}',
            spanTextStyle: TextStyle(
              color: R.colors.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
