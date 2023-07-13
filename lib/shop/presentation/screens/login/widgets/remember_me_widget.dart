import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class RememberMeWidget extends StatelessWidget {
  const RememberMeWidget({
    required this.rememberMeCallBack,
    super.key,
  });
  final Function(bool) rememberMeCallBack;
  @override
  Widget build(BuildContext context) {
    final isCheckBoxChecked =
        context.watch<LoginCubit>().rememberMeValue ?? false;
    return CheckboxListTile(
      value: isCheckBoxChecked,
      onChanged: (newValue) => _handleOnCheckBoxChanged(
        context,
        newValue,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        R.strings.rememberMe,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _handleOnCheckBoxChanged(BuildContext context, bool? newValue) {
    context.read<LoginCubit>().toggleRememberMe(newValue ?? false);
    rememberMeCallBack(
      context.read<LoginCubit>().rememberMeValue ?? false,
    );
  }
}
