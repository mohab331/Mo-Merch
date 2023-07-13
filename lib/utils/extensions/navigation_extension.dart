import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

extension NavigationExtension on BuildContext{
  AppNavigation  get navigator => AppNavigationImpl(context: this,);
}