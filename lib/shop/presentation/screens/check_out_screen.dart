// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/cart/cart_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/address_screen.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/payment_screen.dart';

import '../cubit/check_out/check_out_cubit.dart';
import '../cubit/check_out/check_out_states.dart';
import 'confirm_order_screen.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CheckOutCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appBarCheckOutTitle),
        ),
        body: Builder(builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              CheckOutCubit.get(context).index = 1;
              return true;
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<CheckOutCubit, CheckOutStates>(
                  listener: (context, states) {
                    if (states is CheckOutLoadingState) {
                      AppFunctions.showCupertinoAlertDialog(
                        context,
                        content: SizedBox(
                          height: context.height * 0.1,
                          width: context.width * 0.1,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        title: AppStrings.cupertinoCheckOutTitle,
                        showActions: false,
                      );
                    } else if (states is CheckOutSuccessState) {
                      Navigator.of(context).pop();
                      AppFunctions.showToast(
                        message: states.message,
                        color: AppColors.successColor,
                      );
                    } else if (states is CheckOutErrorState) {
                      Navigator.of(context).pop();
                      AppFunctions.showToast(
                        message: states.error,
                        color: AppColors.errorColor,
                      );
                    } else {}
                  },
                  builder: (context, states) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.grey[200],
                          ),
                          width: double.infinity,
                          height: context.height * 0.1,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                               RowProgressItemBuilder(
                                number: AppStrings.number1,
                                label: AppStrings.shipping,
                                value: 1,
                              ),
                              SizedBox(
                                width: context.width * 0.01,
                              ),
                               RowProgressItemBuilder(
                                number: AppStrings.number2,
                                label: AppStrings.payment,
                                value: 2,
                              ),
                              SizedBox(
                                width: context.width * 0.01,
                              ),
                               RowProgressItemBuilder(
                                number: AppStrings.number3,
                                label: AppStrings.confirm,
                                value: 3,
                              ),
                              SizedBox(
                                width: context.width * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.015,
                        ),
                        CheckOutCubit.get(context).index == 1
                            ? BlocProvider.value(
                                value: CheckOutCubit.get(context),
                                child: const AddressScreen())
                            : CheckOutCubit.get(context).index == 2
                                ? MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: CartCubit.get(context),
                                      ),
                                      BlocProvider.value(
                                        value: CheckOutCubit.get(context),
                                      ),
                                    ],
                                    child: SizedBox(
                                        height: context.height * 0.7,
                                        child: const PaymentScreen()),
                                  )
                                : BlocProvider.value(
                                    value: CartCubit.get(context),
                                    child: SizedBox(
                                        height: context.height * 0.7,
                                        child: const ConfirmOrderScreen())),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class RowProgressItemBuilder extends StatelessWidget {
  const RowProgressItemBuilder(
      {Key? key,
      required this.number,
      required this.label,
      required this.value,})
      : super(key: key);
  final int value;
  final String number;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: CheckOutCubit.get(context).index != value &&
                    CheckOutCubit.get(context).index > value
                ? AppColors.successColor
                : CheckOutCubit.get(context).index == value
                    ? Colors.black
                    : Colors.grey,
            child: CheckOutCubit.get(context).index != value &&
                    CheckOutCubit.get(context).index > value
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : Text(
                    number,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
          ),
           SizedBox(
            width: context.width * 0.01,
          ),
          Text(label),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
