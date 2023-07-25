import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LocationText extends StatelessWidget {
  const LocationText({required this.label, required this.value,super.key,});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value'),
        SizedBox(height: 8.h),
      ],
    )
        : const SizedBox.shrink();
  }
}