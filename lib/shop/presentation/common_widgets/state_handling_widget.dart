import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/error/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/loading_widget.dart';

class StateHandlingWidget extends StatelessWidget {
  const StateHandlingWidget({
    required this.isLoading,
    required this.hasError,
    required this.successWidget,
    required this.onRetryButtonPressed,
    this.loadingIconSize,
    this.loadingWidgetHeight,
    this.loadingWidget,
    this.errorWidget,
    Key? key,
  }) : super(key: key);
  final bool isLoading;
  final bool hasError;
  final double? loadingIconSize;
  final double? loadingWidgetHeight;
  final Widget successWidget;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Function() onRetryButtonPressed;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingWidget ??
            LoadingWidget(
              loadingIconSize: loadingIconSize ?? 40,
              loadingHeight: loadingWidgetHeight,
            )
        : hasError
            ? errorWidget ??
                NetworkErrorWidget(
                  onRetry:  onRetryButtonPressed,
                  isLoading: isLoading,
                )
            : successWidget;
  }
}
