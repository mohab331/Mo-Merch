import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/order/order_cubit.dart';

import '../../../core/utils/app_strings.dart';
import '../cubit/app/app_cubit.dart';
import '../cubit/order/order_states.dart';
import '../widgets/address_item.dart';
import '../widgets/card_item_builder.dart';
import '../widgets/row_icon_item_builder.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<OrderCubit>()..getOrderDetails(context, orderId: orderId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appBarOrderDetailsTitle),
        ),
        body: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, states) {},
          buildWhen: (previousState, currentState) {
            return previousState != currentState &&
                (currentState is OrderGetDetailsDataLoadingState ||
                    currentState is OrderGetDetailsDataSuccessState ||
                    currentState is OrderGetDetailsDataErrorState);
          },
          builder: (context, states) {
            if (states is OrderGetDetailsDataLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (states is OrderGetDataErrorState) {
              return NetworkErrorWidget(onReloadButtonPressed: () {
                OrderCubit.get(context)
                    .getOrderDetails(context, orderId: orderId);
              });
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${AppStrings.orderId}${OrderCubit.get(context).orderDetails!.orderData.id}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      Text(
                        AppStrings.deliveryAddress,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      CardItemBuilder(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowIconItemBuilder(
                                text: AppCubit.get(context).getUserName(),
                                icon: Icons.person),
                            SizedBox(
                              height: context.height * 0.015,
                            ),
                            AddressItem(
                                name: OrderCubit.get(context)
                                    .orderDetails!
                                    .addressData
                                    .name,
                                city: OrderCubit.get(context)
                                    .orderDetails!
                                    .addressData
                                    .city,
                                region: OrderCubit.get(context)
                                    .orderDetails!
                                    .addressData
                                    .region,
                                details: OrderCubit.get(context)
                                    .orderDetails!
                                    .addressData
                                    .details,
                                notes: OrderCubit.get(context)
                                    .orderDetails!
                                    .addressData
                                    .notes),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      Text(
                        AppStrings.paymentMethod,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      CardItemBuilder(
                        child: Column(
                          children: [
                            CheckboxListTile(
                              value: OrderCubit.get(context)
                                          .orderDetails!
                                          .orderData
                                          .paymentMethod ==
                                      AppStrings.cashPaymentMethod
                                  ? true
                                  : false,
                              onChanged: null,
                              title: const Text(AppStrings.cashOnDelivery),
                              controlAffinity: ListTileControlAffinity.leading,
                              selected: OrderCubit.get(context)
                                          .orderDetails!
                                          .orderData
                                          .paymentMethod ==
                                      AppStrings.cashPaymentMethod
                                  ? true
                                  : false,
                            ),
                            SizedBox(
                              height: context.height * 0.03,
                            ),
                            CheckboxListTile(
                              value: OrderCubit.get(context)
                                          .orderDetails!
                                          .orderData
                                          .paymentMethod ==
                                      AppStrings.cashPaymentMethod
                                  ? false
                                  : true,
                              onChanged: null,
                              title: const Text(AppStrings.creditCard),
                              controlAffinity: ListTileControlAffinity.leading,
                              selected: OrderCubit.get(context)
                                          .orderDetails!
                                          .orderData
                                          .paymentMethod ==
                                      AppStrings.cashPaymentMethod
                                  ? false
                                  : true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      CardItemBuilder(
                        child: ExpansionTile(
                          iconColor: Colors.black,
                          collapsedIconColor: Colors.black,
                          title: Text(
                            AppStrings.orderItems,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          subtitle: Text(
                            '${OrderCubit.get(context).orderDetails!.orderData.products.length} ${AppStrings.orderItems}',
                          ),
                          children: [
                            SizedBox(
                              height: context.height * 0.3,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      CachedNetworkImageBuilder(
                                          imageUrl: OrderCubit.get(context)
                                              .orderDetails!
                                              .orderData
                                              .products[index]
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
                                              OrderCubit.get(context)
                                                  .orderDetails!
                                                  .orderData
                                                  .products[index]
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              OrderCubit.get(context)
                                                  .orderDetails!
                                                  .orderData
                                                  .products[index]
                                                  .price
                                                  .toStringAsFixed(2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: OrderCubit.get(context)
                                    .orderDetails!
                                    .orderData
                                    .products
                                    .length,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CardItemBuilder(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomStyleText(
                                  text:
                                      '${AppStrings.orderDate}${OrderCubit.get(context).orderDetails!.date}'),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                              CustomStyleText(
                                text:
                                    '${AppStrings.orderSubtotal}${OrderCubit.get(context).orderDetails!.orderData.cost}',
                              ),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                              CustomStyleText(
                                  text:
                                      '${AppStrings.cartVat}: ${OrderCubit.get(context).orderDetails!.orderData.vat.toStringAsFixed(2)}'),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                              CustomStyleText(
                                text:
                                    '${AppStrings.orderDiscount}${OrderCubit.get(context).orderDetails!.orderData.discount.toStringAsFixed(2)}',
                              ),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                              CustomStyleText(
                                text:
                                    '${AppStrings.orderPromoCode}${OrderCubit.get(context).orderDetails!.promoCode}',
                              ),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                              CustomStyleText(
                                  text:
                                      '${AppStrings.orderPoints}${OrderCubit.get(context).orderDetails!.orderData.points}'),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                              CustomStyleText(
                                text:
                                    '${AppStrings.orderTotal}${OrderCubit.get(context).orderDetails!.orderData.total.toStringAsFixed(2)}',
                              ),
                              SizedBox(
                                height: context.height * 0.015,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomStyleText extends StatelessWidget {
  const CustomStyleText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
    );
  }
}
