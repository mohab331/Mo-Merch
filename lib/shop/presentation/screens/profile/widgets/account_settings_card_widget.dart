import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class AccountSettingsCardWidget extends HookWidget {
  const AccountSettingsCardWidget({
    required this.title,
    required this.onTap,
    required this.trailingIcon,
    required this.leadingIcon,
    this.subtitle,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? subtitle;
  final Function(BuildContext context) onTap;
  final IconData trailingIcon;
  final IconData leadingIcon;
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
        duration: const Duration(
      seconds: 1,
    ),)
      ..forward();
    return SlideTransition(
      position: Tween<Offset>(
        end: Offset.zero,
        begin: const Offset(-1, 0),
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Card(
        elevation: 7.0,
        shadowColor: R.colors.blackColor,
        color: R.colors.lightGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle ?? '',
                  style: const TextStyle(color: Colors.black87),
                )
              : null,
          leading: Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            child: Icon(
              leadingIcon,
              color: R.colors.primaryColor,
            ),
          ),
          onTap: () => onTap(context),
          trailing: Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            child: Icon(
              trailingIcon,
              size: 20,
            ),
          ),
          contentPadding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
