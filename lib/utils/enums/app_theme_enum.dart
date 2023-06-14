/// Enum that represents the available application themes.
enum AppThemeEnum {
  /// Dark theme
  dark(isDarkTheme: true),
  /// Light theme

  light(isDarkTheme: false);

  const AppThemeEnum({
    required this.isDarkTheme,
  });
  final bool isDarkTheme;
}
