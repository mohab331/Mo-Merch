import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    required this.userData,
    Key? key,
  }) : super(key: key);
  final UserResponseEntity userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.0.r,
            child: const Icon(Icons.person,size: 40,),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            userData.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28.0.sp,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          UserBalanceWidget(
            credit: userData.credit,
            points: userData.points,
          ),
        ],
      ),
    );
  }
}

class UserBalanceWidget extends StatelessWidget {
  const UserBalanceWidget({
    required this.credit,
    required this.points,
    Key? key,
  }) : super(key: key);
  final int credit;
  final int points;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${R.strings.credit}${credit.toStringAsFixed(1)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(
          '${R.strings.orderPoints}$points',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
