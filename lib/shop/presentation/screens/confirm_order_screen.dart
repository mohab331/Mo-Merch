import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';

import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/shop_layout.dart';


class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check,size: 200,color: Colors.green,),
            Text(
              AppStrings.orderConfirmed,
              style: Theme.of(context).textTheme.displayLarge,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         AppFunctions.navigateAndRemove(context, screen: const ShopLayout());
        },
        child: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
