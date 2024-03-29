import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    required this.address,
    required this.onLongPressed,
    Key? key,
  }) : super(key: key);

  final AddressResponseEntity address;
  final Function(AddressResponseEntity) onLongPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onLongPressed(address),
      child: AddressListTile(
        address: address,
        onLongPressed: onLongPressed,
      ),
    );
  }
}

class AddressListTile extends StatelessWidget {
  const AddressListTile({
    required this.address,
    required this.onLongPressed,
    Key? key,
  }) : super(key: key);

  final AddressResponseEntity address;
  final Function(AddressResponseEntity) onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(),
        color: R.colors.whiteColor
      ),
      child: Column(
        children: [
          AddressRow(
            address: address,
            onLongPressed: onLongPressed,
          ),
          SizedBox(height: 10.h),
          AddressInfoRow(
            label: 'Name',
            value: address.name,
          ),
          AddressInfoRow(
            label: 'Address',
            value: address.details,
          ),
          AddressInfoRow(
            label: 'City',
            value: address.city,
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}

class AddressRow extends StatelessWidget {
  const AddressRow({
    required this.address,
    required this.onLongPressed,
    Key? key,
  }) : super(key: key);

  final AddressResponseEntity address;
  final Function(AddressResponseEntity) onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(R.images.address,color: R.colors.greyColor,width: 30.w),
        SizedBox(
          width: 140.w,
          child: Text(
            address.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const Spacer(),

        if (address.latitude != 0.0 && address.longitude != 0.0)
          CustomTextButton(
            onPressed: () => _handleOnViewOnMapPressed(
              context,
              addressLatitude: address.latitude,
              addressLongitude: address.longitude,
            ),
            label: 'view on map',
          ),
      ],
    );
  }

  void _handleOnViewOnMapPressed(
    BuildContext context, {
    required double addressLatitude,
    required double addressLongitude,
  }) {
    context.navigator.navigateToMapScreen(
      initialLongitude: addressLongitude,
      initialLatitude: addressLatitude,
    );
  }
}

class AddressInfoRow extends StatelessWidget {
  const AddressInfoRow({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 30.w,
        bottom: 15.h,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 20.w,
              child: Text(
               value.capitalizeFirstLetter() ?? value,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
