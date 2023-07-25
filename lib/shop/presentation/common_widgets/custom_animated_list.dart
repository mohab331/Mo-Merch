import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/utils/enums/index.dart';

/// A custom animated list widget that animates the insertion of items in the list.
class CustomAnimatedList<T> extends StatefulWidget {
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

  /// A callback function that deletes an item from the list.

  @override
  _CustomAnimatedListState<T> createState() => _CustomAnimatedListState<T>();
}

class _CustomAnimatedListState<T> extends State<CustomAnimatedList<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<T> _items = [];

  @override
  void initState() {
    super.initState();
    /// [addPostFrameCallback] method is used to schedule the execution of a function after the current frame is
    /// finished rendering. It is commonly used to perform initialization tasks or trigger actions that require
    /// the UI to be fully rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadItemsWithAnimation();
    });
  }

  /// Loads the items with animation into the list.
  void _loadItemsWithAnimation() {
    for (int i = 0; i < widget.products.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * (i * 2)), () {
        _addItem(widget.products[i]);
      });
    }
  }
  /// Adds an item to the list and animates its insertion.
  void _addItem(T item) {
    _items.add(item);
    _listKey.currentState?.insertItem(_items.length - 1);
  }

  /// Removes an item from the list and animates its removal.
  void deleteItem(T item) {
    if(_items.contains(item)) {
      final index = _items.indexOf(item);
      if(index != -1) {
        _items.removeAt(index);
        _listKey.currentState?.removeItem(
          index,
              (context, animation) => const SizedBox(),
        );
        widget.deletedItem = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
      if(widget.deletedItem != null) {
        deleteItem(widget.deletedItem as T);
      }

    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      controller: widget.controller,
      itemBuilder: (context, index, animation) {
        return widget.animationType == AnimationEnum.size
            ? SizeTransition(
                sizeFactor: animation,
                child: widget.itemBuilder(
                  context,
                  index, // Call deleteItemCallback with the item
                ),
              )
            : SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                        .animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeIn,
                  ),
                ),
                textDirection: TextDirection.ltr,
                child: widget.itemBuilder(
                  context,
                  index,
                ), // Call deleteItemCallback with the item
              );
      },
    );
  }
}
