import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';

class PaginatedList<T> extends HookWidget {
  PaginatedList({
    required this.isLoading,
    required this.onScrollCallBack,
    required this.onEmptyReloadButtonPressed,
    required this.listEmptyIcon,
    required this.listEmptyTitle,
    required this.listChild,
    required this.isEmpty,
    required this.controller,
    this.loadingIconSize,
    this.loadingWidgetHeight,
    this.emptyIconColor,
    Key? key,
  }) : super(key: key);
  bool isLoading;
  final double? loadingIconSize;
  final double? loadingWidgetHeight;
  final Function(BuildContext context) onScrollCallBack;
  final Function() onEmptyReloadButtonPressed;
  final String listEmptyTitle;
  final IconData listEmptyIcon;
  final Widget listChild;
  final bool isEmpty;
  final Color? emptyIconColor;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      final maxScroll = controller.position.maxScrollExtent;
      final currentScroll = controller.position.pixels;
      if (currentScroll == maxScroll && isLoading == false) {
        onScrollCallBack(context);
        isLoading = true;
      }
    });
    return isEmpty
        ? EmptyListWidget(
            isLoading: false,
            onReloadButtonPressed: onEmptyReloadButtonPressed,
            emptyIcon: listEmptyIcon,
            emptyString: listEmptyTitle,
            iconColor: emptyIconColor,
          )
        : Column(
            children: [
              Expanded(
                child: listChild,
              ),
              if (isLoading)
                LoadingWidget(
                  loadingIconSize: loadingIconSize ?? 40,
                  loadingHeight: loadingWidgetHeight,
                ),
            ],
          );
  }
}
