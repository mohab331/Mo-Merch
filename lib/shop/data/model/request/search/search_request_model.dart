import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class SearchRequestModel implements BaseRequestModel {

  const SearchRequestModel({
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
