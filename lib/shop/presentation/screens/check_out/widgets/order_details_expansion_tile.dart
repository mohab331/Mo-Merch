import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class OrderDetailsExpansionTile extends StatelessWidget {
  const OrderDetailsExpansionTile({

    required this.cartItemsList,
    super.key,
  });

  final List<CartItem> cartItemsList;

  @override
  Widget build(BuildContext context) {
    final pay = context.read<CartCubit>().cartTotal + (context.read<CartCubit>().cartTotal*0.14);
    return ExpansionTile(
      title: Text(
        'Click to expand',
        style: TextStyle(fontSize: 16.sp),
      ),
      children: [
        SizedBox(

          height:   (cartItemsList.length * 70).h ,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: OrderItemWidget(
                  itemInCart: cartItemsList[index],
                ),
              );
            },
            itemCount: cartItemsList.length,
          ),
        ),
        SizedBox(height: 20.h),
        TotalContainer(
          totalCartPrice: pay,
          totalItems: cartItemsList.length.toString(),
        ),
      ],
    );
  }
}
