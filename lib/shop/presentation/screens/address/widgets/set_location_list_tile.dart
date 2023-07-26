import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class SetLocationListTile extends StatelessWidget {
  const SetLocationListTile({
    required this.addressData,
    required this.setLatLng,
    Key? key,
  }) : super(key: key);

  final LocationInfo? addressData;
  final void Function(LocationInfo?) setLatLng;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.map_outlined,
        color: R.colors.greenColor,
      ),
      title: Text(
        addressData != null
            ? ' ${addressData?.address?.street}'
            : 'set location on maps',
        style: TextStyle(
          color: R.colors.blackColor,
          fontSize: 16.sp,
        ),
      ),
      onTap: () {
        context.navigator.navigateToMapScreen(
          onLocationSaved: (value) => setLatLng(value),
        );
      },
    );
  }
}
