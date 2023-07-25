import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class MapsModalBottomSheet extends StatelessWidget {
  const MapsModalBottomSheet({
    required this.location,
    required this.onSaveTapped,
    Key? key,
  }) : super(key: key);

  final LocationInfo location;
  final Function(LocationInfo?) onSaveTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LocationText(
          label: 'Lat',
          value: location.latLng?.latitude.toString(),
        ),
        LocationText(
          label: 'Long',
          value: location.latLng?.longitude.toString(),
        ),
        LocationText(label: 'Name', value: location.address?.name),
        LocationText(label: 'Country', value: location.address?.country),
        LocationText(label: 'Street', value: location.address?.street),
        LocationText(
            label: 'Area', value: location.address?.administrativeArea),
        SizedBox(height: 16.h),
        Container(
          alignment: Alignment.topRight,
          child: CustomTextButton(label: 'Save', onPressed: (){
            onSaveTapped.call(location);
            Navigator.of(context).pop();
          },),
        ),
      ],
    );
  }
}


