import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SearchRequestEntity implements BaseRequestEntity {
  final String text;

  const SearchRequestEntity({
    required this.text,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
