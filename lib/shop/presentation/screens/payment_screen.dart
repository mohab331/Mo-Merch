import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/cart/cart_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/check_out/check_out_cubit.dart';

import '../../../core/utils/app_strings.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(AppStrings.orderSummary,
                  style: Theme.of(context).textTheme.bodyLarge),
              iconColor: Colors.black,
              children: [
                SizedBox(
                  height: context.height * 0.24,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          CachedNetworkImageBuilder(
                              imageUrl: CartCubit.get(context)
                                  .cartMap[CartCubit.get(context)
                                      .cartMap
                                      .keys
                                      .elementAt(index)]!
                                  .product
                                  .image,
                              width: context.width * 0.1,
                              height: context.height * 0.1),
                          SizedBox(
                            width: context.width * 0.015,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  CartCubit.get(context)
                                      .cartMap[CartCubit.get(context)
                                          .cartMap
                                          .keys
                                          .elementAt(index)]!
                                      .product
                                      .name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  CartCubit.get(context)
                                      .cartMap[CartCubit.get(context)
                                          .cartMap
                                          .keys
                                          .elementAt(index)]!
                                      .product
                                      .price
                                      .toStringAsFixed(2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                    itemCount: CartCubit.get(context).cartMap.length,
                  ),
                ),
                Container(
                  height: context.height * 0.04,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Text(
                    'Total: ${(CartCubit.get(context).cartSubtotal.toStringAsFixed(2))}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            Text(
              AppStrings.choosePaymentMethod,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 25),
            ),
            Text(
              AppStrings.paymentMethodSubtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            Container(
              color: Colors.white,
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.cashOnDelivery,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black)),
                    const Icon(
                      Icons.delivery_dining,
                      size: 30,
                    )
                  ],
                ),
                value: true,
                onChanged: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CheckOutCubit.get(context).createOrder(context);

        },
        child: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
