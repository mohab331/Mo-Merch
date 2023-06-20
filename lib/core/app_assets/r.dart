
import 'package:shop_app_clean_architecture/core/app_assets/index.dart';

class R {
  R._internal();

  /// Accessor for the `AppColors` instance.
  static AppColors colors = AppColors();

  /// Accessor for the `AppFunctions` instance.
  static AppFunctions functions = AppFunctions();

  /// Accessor for the `AppImages` instance.
  static AppImages images = const AppImages();

  /// Accessor for the `AppStrings` instance.
  static AppStrings strings = const AppStrings();
}
