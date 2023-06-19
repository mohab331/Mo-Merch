import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';

import '../utils/app_strings.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({Key? key, required this.onReloadButtonPressed})
      : super(key: key);
  final Function onReloadButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 100,
            color: Colors.red,
          ),
          SizedBox(
            height: context.height * 0.04,
          ),
          Text(
            AppStrings.errorLoading,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            width: context.width * 0.7,
            child: ElevatedButton(
              onPressed: () {
                onReloadButtonPressed(context);
              },
              child: const Text(
                AppStrings.reload,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
