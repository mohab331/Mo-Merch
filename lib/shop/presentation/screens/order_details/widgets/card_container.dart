import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    required this.child,
    this.cardElevation,
    this.cardColor,
    this.padding,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double? cardElevation;
  final EdgeInsetsGeometry? padding;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? Colors.white,
      elevation: cardElevation ?? 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
