import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CheckOutConfirmationWidget extends StatefulWidget {
  const CheckOutConfirmationWidget({
    required this.orderResponseEntity,
    Key? key,
  }) : super(key: key);
  final OrderResponseEntity? orderResponseEntity;

  @override
  State<CheckOutConfirmationWidget> createState() =>
      _CheckOutConfirmationWidgetState();
}

class _CheckOutConfirmationWidgetState
    extends State<CheckOutConfirmationWidget> {
  @override
  void initState() {
    R.functions.showToast(
      message: 'You will be returned to home screen in 5 seconds',
      color: R.colors.greenColor,
    );
    diInstance.get<NotificationRepo>().showLocalNotification(
          RemoteMessage(
            notification: RemoteNotification(
                title: 'Order Confirmed',
                body:
                    'Order with ID: ${widget.orderResponseEntity?.id} placed successfully'),
          ),
        );
    //
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
      onWillPop: () => Future.value(false),
      child: SizedBox(
        width: double.infinity,
        height: 600.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: R.colors.greenColor,
                size: 120,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Thank you for your purchase !',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            Text(
              'Your order has been received',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
            TextWithSpan(
              mainText: 'Order ID: ',
              spanText: widget.orderResponseEntity?.id.toString() ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
