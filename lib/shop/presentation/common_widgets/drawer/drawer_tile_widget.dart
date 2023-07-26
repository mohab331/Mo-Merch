import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({
    required this.title,
    required this.icon,
    required this.onItemTapped,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);
  final Function() onItemTapped;
  final String title;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: isLoading ? null : onItemTapped,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: R.colors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
