import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:shop_app_clean_architecture/core/index.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {required this.loadingIconSize, this.loadingHeight, Key? key})
      : super(key: key);
  final double loadingIconSize;
  final double? loadingHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: loadingHeight?.h ?? 100.h,
        child: LoadingAnimationWidget.discreteCircle(
          color: R.colors.primaryColor,
          size: loadingIconSize,
        ),
      ),
    );
  }
}
