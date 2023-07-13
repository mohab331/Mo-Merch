import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

/// A class that defines the dark and light themes for the application.
/// The themes consist of various styling configurations for different UI elements.
class AppTheme {
  /// Returns the dark theme for the application.
  static ThemeData darkTheme() => ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: R.colors.appBackgroundDarkThemeColor,
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
            statusBarColor: R.colors.appBackgroundDarkThemeColor,
            statusBarBrightness: Brightness.light,
          ),
        ),
        textTheme: const TextTheme(
          // Custom text styles for different sizes and purposes
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.grey,
          ),
          displayLarge: TextStyle(
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
          ),
        ),
        primarySwatch: R.colors.primaryColor,
        scaffoldBackgroundColor: R.colors.appBackgroundDarkThemeColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20.0,
          backgroundColor: R.colors.appBackgroundDarkThemeColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: R.colors.primaryColor,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        drawerTheme: DrawerThemeData(
          elevation: 20.0,
          backgroundColor: R.colors.appBackgroundDarkThemeColor,
        ),
        unselectedWidgetColor: Colors.white, // Color for unselected widgets
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
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
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: R.colors.errorColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
      );

  /// Returns the light theme for the application.
  static ThemeData lightTheme() => ThemeData(
        primarySwatch: R.colors.primaryColor,
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
          // Custom text styles for different sizes and purposes
          bodyLarge: TextStyle(
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            color: Colors.grey,
          ),
          displayLarge: TextStyle(
            fontSize: 34,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20.0,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: R.colors.primaryColor,
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
          contentPadding: EdgeInsets.zero,
          dense: true,
          horizontalTitleGap: 0.0,
          minLeadingWidth: 0.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIconColor: Colors.black,
          suffixIconColor: Colors.black,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: R.colors.errorColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
      );
}
