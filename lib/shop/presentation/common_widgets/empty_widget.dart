import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';


class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key,required this.iconData , required this.title,}) : super(key: key);
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(
            iconData,
            size: 200,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
