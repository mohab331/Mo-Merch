import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({
    required this.title,
    required this.icon,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);
  final Function() onItemTapped;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onItemTapped,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
