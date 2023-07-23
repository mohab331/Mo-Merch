import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/buttons/custom_text_button.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/auth_state.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CreateAccountRowWidget extends StatelessWidget {
  const CreateAccountRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          R.strings.createAnAccount,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomTextButton(
          label: R.strings.register,
          onPressed: () => context.navigator.navigateToRegisterScreen(),
          labelFontSize: 18.sp,
          buttonPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          isEnabled: (context.watch<AuthCubit>().state is! AuthenticationLoadingState) ,
        ),
      ],

    );
  }
}
