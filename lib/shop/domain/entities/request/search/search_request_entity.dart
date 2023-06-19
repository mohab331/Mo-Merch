import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SearchRequestEntity implements BaseRequestEntity {

  const SearchRequestEntity({
    required this.text,
  });
  final String text;

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
