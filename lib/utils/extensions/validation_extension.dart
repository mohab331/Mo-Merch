import 'package:shop_app_clean_architecture/core/index.dart';

extension ValidationExtension on String? {
  /// Validates an email address.
  ///
  /// Returns an error message if the email address is empty or invalid.
  /// Returns `null` if the email address is valid.
  ///
  /// The email address is considered valid if it follows the standard email address format:
  /// - The local part before the @ symbol consists of one or more lowercase letters (a-z),
  ///   digits (0-9), and special characters (! # $ % & ' * + / = ? ^ _ ` { | } ~ -).
  ///   It can also include a dot (.) and additional characters after it.
  /// - The domain part after the @ symbol consists of one or more subdomains separated by dots.
  ///   Each subdomain starts and ends with a lowercase letter or digit and can include hyphens (-) in between.

   String? validateEmailAddress() {
    if (this == null || this!.isEmpty) {
      return R.strings.emptyEmailAddress;
    }
    else if (RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this!) == false) {
      return R.strings.invalidEmail;
    }
    else {
      return null;
    }
  }

  /// Validates a user name.
  ///
  /// Returns an error message if the user name is empty.
  /// Returns `null` if the user name is valid.
  ///
  /// The user name is considered valid if it is not empty.
  ///
   String? validateUserName() {
    if (this == null || this!.isEmpty) {
      return R.strings.emptyName;
    }
    else {
      return null;
    }
  }



  /// Validates a password.
  ///
  /// Returns an error message if the password is empty or if the confirmation password
  /// is provided and does not match the password.
  /// Returns `null` if the password is valid.
  ///
  /// The password is considered valid if it is not empty. If a confirmation password
  /// is provided, it should match the password for validation to pass.
  ///
   String? validatePassword({String? confirmationPassword}) {
    if (this == null || this!.isEmpty) {
      return R.strings.emptyPassword;
    }
    else if (confirmationPassword != null && confirmationPassword != this) {
      return R.strings.wrongConfirmPassword;
    }
    else {
      return null;
    }
  }


   String? validateIsEmpty() {
    if (this == null || this!.isEmpty) {
      return R.strings.emptyValue;
    }
    return null;
  }
}
