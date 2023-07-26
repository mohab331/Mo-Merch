import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class AddressPaymentListTile extends StatelessWidget {
  const AddressPaymentListTile({required this.title,this.leading,this.trailingIcon,this.onListTapped,super.key,});
  final Widget? leading;
  final IconData? trailingIcon;
  final String title;
  final Function()? onListTapped;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
        ),
      ),
      leading:leading ,
      trailing: Icon(
        trailingIcon,
        size: 25,
        color: R.colors.blackColor,
      ),
      onTap: onListTapped,
    );
  }
}