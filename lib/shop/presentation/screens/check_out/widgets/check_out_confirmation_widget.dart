import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

import '../../../../../core/index.dart';

class CheckOutConfirmationWidget extends StatefulWidget {
  const CheckOutConfirmationWidget(
      {required this.orderResponseEntity, Key? key})
      : super(key: key);
  final OrderResponseEntity? orderResponseEntity;

  @override
  State<CheckOutConfirmationWidget> createState() =>
      _CheckOutConfirmationWidgetState();
}

class _CheckOutConfirmationWidgetState
    extends State<CheckOutConfirmationWidget> {
  @override
  void initState() {
    R.functions.showToast(message: 'You will be returned to home screen in 5 seconds', color: Colors.green,);
    /// [addPostFrameCallback] method is used to schedule the execution of a function after the current frame is
    /// finished rendering. It is commonly used to perform initialization tasks or trigger actions that require
    /// the UI to be fully rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(
          seconds: 5,
        ),
        () {
          context.navigator.navigateToShopLayout();
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: SizedBox(
        height: 400.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                TextWithSpan(
                  mainText: 'Order ID: ',
                  spanText: widget.orderResponseEntity?.id.toString() ?? '',
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextWithSpan(
                  mainText: 'Order total: ',
                  spanText: widget.orderResponseEntity?.total.toString() ?? '',
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextWithSpan(
                  mainText: 'Address: ',
                  spanText: context.read<CheckOutCubit>().chosenAddress?.name ??
                      'No address',
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
