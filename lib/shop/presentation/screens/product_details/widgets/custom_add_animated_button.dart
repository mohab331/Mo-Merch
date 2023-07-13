import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class CustomAddAnimatedButton extends StatefulWidget {
  const CustomAddAnimatedButton({Key? key,required this.onButtonPressed,required this.buttonLabel}) : super(key: key);
  final Function onButtonPressed;
  final String buttonLabel;

  @override
  State<CustomAddAnimatedButton> createState() => _CustomAddAnimatedButtonState();
}

class _CustomAddAnimatedButtonState extends State<CustomAddAnimatedButton> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;

  @override
  Widget build(BuildContext context) {
    return AddToCartButton(
      trolley: Image.asset(
        R.images.icCart,
        width: 24.w,
        height: 24.h,
        color: Colors.white,
      ),
      text: Text(
        widget.buttonLabel,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
      check: const SizedBox(
        width: 48,
        height: 48,
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 24,
        ),
      ),
      borderRadius: BorderRadius.circular(24),
      backgroundColor: R.colors.primaryColor,
      onPressed: (id) {
        if (id == AddToCartButtonStateId.idle) {
          widget.onButtonPressed();
          setState(() {
            stateId = AddToCartButtonStateId.loading;
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                setState(() {
                  stateId = AddToCartButtonStateId.done;
                });
              }
            });
          });
        } else if (id == AddToCartButtonStateId.done) {
          //handle logic when pressed on done state button.
          setState(() {
            stateId = AddToCartButtonStateId.idle;
          });
        }
      },
      stateId: stateId,
    );
  }
}
