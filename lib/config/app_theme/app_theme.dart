import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

/// A class that defines the dark and light themes for the application.
/// The themes consist of various styling configurations for different UI elements.
class AppTheme {
  /// Returns the dark theme for the application.
  static ThemeData darkTheme() => ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: R.colors.whiteColor,
          ),
          backgroundColor: R.colors.appBackgroundDarkThemeColor,
          actionsIconTheme: IconThemeData(
            color: R.colors.whiteColor,
          ),
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: R.colors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 24.0.sp,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: R.colors.appBackgroundDarkThemeColor,
            statusBarBrightness: Brightness.light,
          ),
        ),
    textTheme: TextTheme(
          // Custom text styles for different sizes and purposes
          bodyLarge: TextStyle(
            color: R.colors.whiteColor,
          ),
          bodyMedium: TextStyle(
            color: R.colors.whiteColor,
          ),
          bodySmall: TextStyle(
            color: R.colors.greyColor,
          ),
          displayLarge: TextStyle(
            color: R.colors.whiteColor,
          ),
          displaySmall: TextStyle(
            color: R.colors.whiteColor,
          ),
        ),
        primarySwatch: R.colors.primaryColor,
        scaffoldBackgroundColor: R.colors.appBackgroundDarkThemeColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20.0,
          backgroundColor: R.colors.appBackgroundDarkThemeColor,
          unselectedItemColor: R.colors.whiteColor,
          selectedItemColor: R.colors.primaryColor,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: IconThemeData(
          color: R.colors.whiteColor,
        ),
        drawerTheme: DrawerThemeData(
          elevation: 20.0,
          backgroundColor: R.colors.appBackgroundDarkThemeColor,
        ),
        unselectedWidgetColor: R.colors.whiteColor,
        // Color for unselected widgets
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: R.colors.whiteColor,
              width: 2.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0.r,
            ),
            borderSide: BorderSide(
              color: R.colors.whiteColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0.r,
            ),
            borderSide: BorderSide(
              color: R.colors.whiteColor,
            ),
          ),
          labelStyle: TextStyle(
            color: R.colors.whiteColor,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold,
          ),
          prefixIconColor: R.colors.whiteColor,
          suffixIconColor: R.colors.whiteColor,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: R.colors.redColor,
              width: 2.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: R.colors.whiteColor,
              width: 2.w,
            ),
          ),
        ),
      );

  /// Returns the light theme for the application.
  static ThemeData lightTheme() => ThemeData(
        primarySwatch: R.colors.primaryColor,
    appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: R.colors.blackColor,
          ),
          backgroundColor: R.colors.whiteColor,
          actionsIconTheme: IconThemeData(
            color: R.colors.blackColor,
          ),
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: R.colors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 24.0.sp,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: R.colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
        ),
    textTheme: TextTheme(
          // Custom text styles for different sizes and purposes
          bodyLarge: TextStyle(
            color: R.colors.blackColor,
          ),
          bodyMedium: TextStyle(
            color: R.colors.blackColor,
          ),
          bodySmall: TextStyle(
            color: R.colors.greyColor,
          ),
          displayLarge: TextStyle(
            fontSize: 34.sp,
            color: R.colors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: R.colors.whiteColor,
          ),
        ),
        scaffoldBackgroundColor: R.colors.whiteColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20.0,
          backgroundColor: R.colors.whiteColor,
          unselectedItemColor: R.colors.blackColor,
          selectedItemColor: R.colors.primaryColor,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: IconThemeData(
          color: R.colors.blackColor,
        ),
        drawerTheme: DrawerThemeData(
          elevation: 20.0,
          backgroundColor: R.colors.whiteColor,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.zero,
          dense: true,
          horizontalTitleGap: 0.0,
          minLeadingWidth: 0.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0.r,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
          ),
          labelStyle: TextStyle(
            color: R.colors.blackColor,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold,
          ),
          prefixIconColor: R.colors.blackColor,
          suffixIconColor: R.colors.blackColor,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: R.colors.redColor,
              width: 2.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.w,
            ),
          ),
        ),
      );
}
