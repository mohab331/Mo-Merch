import 'package:intl/intl.dart';

extension PriceFormatExtension on int? {
  String formatPrice() {
    final priceFormat = NumberFormat.currency(locale: 'en_US',decimalDigits: 0,symbol: '',);
    if (this != null) {
      return priceFormat.format(this!);
    } else {
      return '';
    }
  }
}

extension Format on double? {
  String doubleToPrice() {
    final priceFormat = NumberFormat.currency(locale: 'en_US',decimalDigits: 0,symbol: '',);
    if (this != null) {
      return priceFormat.format(this!);
    } else {
      return '';
    }
  }
}