import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// A custom animated list widget that animates the insertion of items in the list.
class CustomAnimatedList<T> extends HookWidget {
  /// Constructs a [CustomAnimatedList] widget.
  ///
  /// The [products] parameter is the list of items to be displayed in the animated list.
  /// The [itemBuilder] is a callback function that builds the widgets for each item in the list.
  /// The [controller] is an optional [ScrollController] for controlling the scroll position of the list.
  CustomAnimatedList({
    required this.products,
    required this.itemBuilder,
    this.animationType = AnimationEnum.size,
    this.controller,
    this.deletedItem,
    Key? key,
  }) : super(key: key);

  /// The list of items to be displayed in the animated list.
  final List<T> products;

  /// A callback function that builds the widgets for each item in the list.
  final IndexedWidgetBuilder itemBuilder;
  T? deletedItem;

  /// An optional [ScrollController] for controlling the scroll position of the list.
  final ScrollController? controller;

  /// The type of animation to use for item insertion.
  final AnimationEnum animationType;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(
        milliseconds: 500,
      ),
    )..forward();

    return ListView.builder(
      itemCount: products.length,
      controller: controller,
      itemBuilder: (
        context,
        index,
      ) {
        return animationType == AnimationEnum.size
            ? SizeTransition(
                sizeFactor: animationController,
                child: itemBuilder(
                  context,
                  index, // Call deleteItemCallback with the item
                ),
              )
            : SlideTransition(
                position: Tween<Offset>(
                        begin: Offset((-1 * (index == 0 ? 1:index  + 0.15)).toDouble(), 0),
                        end: Offset.zero,)
                    .animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeIn,
                  ),
                ),
                textDirection: TextDirection.ltr,
                child: itemBuilder(
                  context,
                  index,
                ), // Call deleteItemCallback with the item
              );
      },
    );
  }
}
