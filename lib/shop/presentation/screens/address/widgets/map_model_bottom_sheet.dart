import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

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
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Lat: ${location.latLng?.latitude}',
          ),
          SizedBox(height: 8.h),
          Text('Long: ${location.latLng?.longitude}'),
          SizedBox(height: 8.h),
          Text('Name: ${location.address?.name}'),
          SizedBox(height: 8.h),
          Text('Country: ${location.address?.country}'),
          SizedBox(height: 8.h),
          Text('Street: ${location.address?.street}'),
          SizedBox(height: 8.h),
          Text('Area: ${location.address?.administrativeArea}'),
          SizedBox(height: 16.h),
          Container(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                onSaveTapped.call(location,);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }




}
