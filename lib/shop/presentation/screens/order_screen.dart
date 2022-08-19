import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/loading_data_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/order/order_cubit.dart';

import '../../../core/utils/app_strings.dart';
import '../cubit/order/order_states.dart';
import 'order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      if (currentScroll == maxScroll && _isLoading == false) {
        Future.delayed(Duration.zero, () {
          _getMoreOrders();
        });
      }
    });
  }

  void _getMoreOrders() {
    OrderCubit.get(context).currentOrderPage += 1;
    OrderCubit.get(context).getOrders(
      context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {});
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarOrderTitle),
      ),
      body: BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, states) {
          if (states is OrderGetDataSuccessState ||
              states is OrderGetDataErrorState) {
            _isLoading = false;
          } else if (states is OrderGetDataErrorState) {
            AppFunctions.showToast(
                message: states.errorMessage, color: AppColors.errorColor);
          } else if (states is OrderGetDataLoadingState &&
              OrderCubit.get(context).hasMoreOrdersData == true &&
              OrderCubit.get(context).fetchedOrders.isNotEmpty) {
            _isLoading = true;
          } else {}
        },
        buildWhen: (previousState, currentState) {
          return previousState != currentState &&
              (currentState is OrderGetDataErrorState ||
                  currentState is OrderGetDataSuccessState ||
                  currentState is OrderGetDataLoadingState);
        },
        builder: (context, states) {
          if (states is OrderGetDataLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (states is OrderGetDataSuccessState &&
              OrderCubit.get(context).fetchedOrders.isEmpty) {
            return const EmptyWidget(
                iconData: Icons.shopping_bag, title: AppStrings.emptyOrders);
          } else if (states is OrderGetDataErrorState &&
              OrderCubit.get(context).fetchedOrders.isEmpty) {
            return NetworkErrorWidget(
                onReloadButtonPressed: (BuildContext context) {
              OrderCubit.get(context).currentOrderPage = 1;
              OrderCubit.get(context).getOrders(context);
            });
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: OrderCubit.get(context).fetchedOrders.length,
                    itemBuilder: (context, index) {
                      return OrderItem(
                        order: OrderCubit.get(context).fetchedOrders[index],
                      );
                    },
                  ),
                ),
                if (_isLoading && states is! OrderGetDataErrorState)
                  const LoadingDataWidgetBuilder(),
                if (states is OrderGetDataErrorState &&
                    OrderCubit.get(context).fetchedOrders.isNotEmpty)
                  NetworkErrorWidget(
                      onReloadButtonPressed: (BuildContext context) {
                    OrderCubit.get(context).getOrders(context);
                  }),
              ],
            );
          }
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final GetOrderResponseDataItem order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFunctions.navigateTo(
          context: context,
          screen: OrderDetailsScreen(
            orderId: order.id,
          ),
        );
      },
      child: Card(
        elevation: 20,
        margin: const EdgeInsets.all(15.0),
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStrings.order}${order.id}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                        Text(
                          '${AppStrings.orderStatus}${order.status}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    order.date,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.015,
              ),
              Text(
                '${AppStrings.orderTotal}${order.total.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
