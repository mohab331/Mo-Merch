import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  // Constructor
  AppColors();

  // App Background Dark Theme Colors
  final Color appBackgroundDarkThemeColor = HexColor('121212');
  final Color blackColor = Colors.black;
  final Color lightBlack = Colors.black12;

  // Primary Colors
  final MaterialColor primaryColor = Colors.deepOrange;

  // Success Colors
  final Color greenColor = Colors.green;

  // Remove Colors
  final Color redColor = Colors.red;
  final Color darkRed = Colors.red[900] ?? Colors.red;
  final Color lightRed = Colors.redAccent;

  // Grey Colors
  final Color greyColor = Colors.grey;
  final Color darkGrey = Colors.grey[850] ?? Colors.grey;
  final Color mediumGrey = Colors.grey[800] ?? Colors.grey;
  final Color lightGrey = Colors.grey[200] ?? Colors.grey;

  // Opacity Colors
  final Color deepOrangeWithOpacity = Colors.deepOrange.withOpacity(0.8);
  final Color blueGreyWithOpacity = Colors.blueGrey.withOpacity(0.7);

  // Other Colors
  final Color transparent = Colors.transparent;
  final Color whiteColor = Colors.white;
  final Color lightWhite = Colors.white54;
}
