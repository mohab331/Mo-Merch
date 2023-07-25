import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/enums/animation_enum.dart';

class OrderContent extends HookWidget {
  const OrderContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    final orderState = context
        .watch<OrderCubit>()
        .state;
    final ordersList = orderCubit.ordersMap.values.toList();
    final scrollController = useScrollController();
    return StateHandlingWidget(
      isLoading: orderState is OrderLoadingState && ordersList.isEmpty,
      hasError: orderState is OrderErrorState,
      successWidget: PaginatedList(
        isLoading: orderCubit is OrderLoadingState,
        onEmptyReloadButtonPressed: () => _handleOnReloadPressed(orderCubit),
        controller: scrollController,
        isEmpty: ordersList.isEmpty,
        listEmptyWidget: SvgPicture.asset(R.images.emptyOrder, width: 150.w,),
        listEmptyTitle: R.strings.emptyOrders,
        onScrollCallBack: (context) => _handleScrollCallBack(orderCubit),
        emptyIconColor: Colors.green,
        listChild: CustomAnimatedList(
          itemBuilder: (context, index) {
            return BlocProvider<EditOrderCubit>(
              create: (context) => diInstance.get<EditOrderCubit>(),
              child: OrderCard(order: ordersList[index],),
            );
          },
          products: ordersList,
          controller: scrollController,
          animationType: AnimationEnum.slide,
        ),
      ),
      onRetryButtonPressed: () => _handleOnReloadPressed(orderCubit),
    );
  }

  void _handleOnReloadPressed(OrderCubit orderCubit) {
    orderCubit.getOrders(
      page: orderCubit.currentPage,
    );
  }

  void _handleScrollCallBack(OrderCubit orderCubit) {
    final page = orderCubit.currentPage + 1;
    orderCubit.getOrders(page: page);
  }
}
