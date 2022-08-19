import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme() => ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.appBackgroundDarkThemeColor,
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.appBackgroundDarkThemeColor,
            statusBarBrightness: Brightness.light,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: TextStyle(
            fontSize: 34,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
         displaySmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
        primarySwatch: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.appBackgroundDarkThemeColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20.0,
          backgroundColor: AppColors.appBackgroundDarkThemeColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        drawerTheme: DrawerThemeData(
          elevation: 20.0,
          backgroundColor: AppColors.appBackgroundDarkThemeColor,
        ),
        unselectedWidgetColor: Colors.white, // <-- your color
        inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            prefixIconColor: Colors.white,
            suffixIconColor: Colors.white,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.errorColor,
                width: 2,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            )),
      );

  static ThemeData lightTheme() => ThemeData(
        primarySwatch: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: TextStyle(
            fontSize: 34,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20.0,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: AppColors.primaryColor,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        drawerTheme: const DrawerThemeData(
          elevation: 20.0,
          backgroundColor: Colors.white,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.all(0),
          dense: true,
          horizontalTitleGap: 0.0,
          minLeadingWidth: 0.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            prefixIconColor: Colors.black,
            suffixIconColor: Colors.black,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.errorColor,
                width: 2,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            )),
      );
}
