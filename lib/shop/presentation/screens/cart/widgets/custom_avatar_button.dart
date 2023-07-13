import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAvatarButton extends StatelessWidget {
  const CustomAvatarButton({required this.icon , required this.onButtonTap , Key? key}) : super(key: key);
  final IconData icon;
  final Function() onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onButtonTap,
        child: CircleAvatar(
          radius: 13.0.r,
          child: Icon(
            icon,
          ),
        ),
      ),
    );
  }
}