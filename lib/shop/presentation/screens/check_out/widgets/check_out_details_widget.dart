import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class CheckOutDetailsWidget extends StatelessWidget {
  const CheckOutDetailsWidget(
      {required this.cartItems, required this.onChoseAddressPressed, Key? key})
      : super(key: key);
  final List<CartItem> cartItems;
  final Function(AddressResponseEntity?) onChoseAddressPressed;
  @override
  Widget build(BuildContext context) {
    final checkOutCubit = context.read<CheckOutCubit>();
    return BlocListener<CheckOutCubit, CheckOutState>(
      listener: (context, state) {
        if (state is PlaceOrderLoadingState) {
          R.functions.showCupertinoAlertDialog(
            context,
            content: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: const LoadingWidget(
                loadingIconSize: 40,
              ),
            ),
            title: 'placing order',
            showNoAction: false,
            showOkAction: false,
          );
        } else if (state is PlaceOrderSuccessState) {
          R.functions.showToast(
            message: state.message ?? 'Order place successfully',
            color: state.toastColor ?? Colors.green,
          );
          checkOutCubit.toggleIndex(checkOutCubit.index + 1);
        }else{
          Navigator.pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Text(
            'Order Items:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: OrderDetailsExpansionTile(
              cartItemsList: cartItems,
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            'Payment:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 20.h),
          AddressPaymentListTile(
            title: 'Cash On Delivery',
            trailingIcon: Icons.delivery_dining_outlined,
            leading: Checkbox(
              value: true,
              onChanged: (_) {},
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Address:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: AddressPaymentListTile(
              title: context.watch<CheckOutCubit>().chosenAddress?.name ??
                  'choose address',
              trailingIcon: Icons.location_on,
              onListTapped: () {
                context.navigator.navigateToAddressScreen(
                  onAddressPressed: (address) => onChoseAddressPressed(address),
                );
              },
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.topRight,
            child: CustomTextButton(
              label: 'Confirm Order',
              onPressed: () => _onConfirmOrderButtonPressed(
                context: context,
                checkOutCubit: checkOutCubit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirmOrderButtonPressed({
    required BuildContext context,
    required CheckOutCubit checkOutCubit,
  }) {
    if (checkOutCubit.chosenAddress == null) {
      R.functions.showToast(
        message: 'Choose address',
        color: Colors.red,
      );
      return;
    }
    checkOutCubit.placeOrder(
      cartCubit: context.read<CartCubit>(),
    );
  }
}
