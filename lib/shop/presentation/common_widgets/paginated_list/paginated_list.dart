import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';

class PaginatedList<T> extends HookWidget {
   PaginatedList({
    required this.isLoading,
    required this.onScrollCallBack,
    required this.listEmptyIcon,
    required this.listEmptyTitle,
    required this.listChild,
    required this.isEmpty,
    required this.controller,
    this.loadingIconSize,
    this.loadingWidgetHeight,
    this.iconColor,
    Key? key,
  }) : super(key: key);
  bool isLoading;
  final double? loadingIconSize;
  final double? loadingWidgetHeight;
  final Function(BuildContext context) onScrollCallBack;
  final String listEmptyTitle;
  final IconData listEmptyIcon;
  final Widget listChild;
  final bool isEmpty;
  final Color? iconColor;
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
        ? EmptyWidget(
      iconData: listEmptyIcon,
      title: listEmptyTitle,
      iconColor: iconColor,
    )
        : Column(
      children: [
        Expanded(
          child: listChild,
        ),

        if (isLoading)  LoadingWidget(loadingIconSize:loadingIconSize ?? 40 ,loadingHeight: loadingWidgetHeight,),
      ],
    );
  }
}