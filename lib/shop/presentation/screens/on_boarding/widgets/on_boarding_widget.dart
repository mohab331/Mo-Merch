import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    required this.imageAssetPath,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String imageAssetPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(imageAssetPath,),
            fit: BoxFit.contain,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
