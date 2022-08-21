import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
class RowIconItemBuilder extends StatelessWidget {
  const RowIconItemBuilder({Key? key, required this.text, required this.icon})
      : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
         SizedBox(
          width: context.width * 0.015,
        ),
        SizedBox(
          width: context.width * 0.015,
        ),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
        )
      ],
    );
  }
}