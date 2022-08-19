import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
class LoadingDataWidgetBuilder extends StatelessWidget {
  const LoadingDataWidgetBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: context.height * 0.04,
      width: context.width,
      child: const Center(child: CircularProgressIndicator(),),
    );
  }
}
