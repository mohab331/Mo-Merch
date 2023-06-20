/// Enum that represents the available application themes.
enum AppThemeEnum {
  /// Dark theme
  dark(value: true),
  /// Light theme

  light(value: false);

  const AppThemeEnum({
    required this.value,
  });
  final bool value;
}
