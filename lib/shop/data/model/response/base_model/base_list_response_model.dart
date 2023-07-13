import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class BaseListResponseModel<T extends JsonConverter> {
  const BaseListResponseModel({
    required this.modelList,
    this.status,
    this.message,
    this.currentPage,
    this.nextPageUrl,
    this.total,
  });

  factory BaseListResponseModel.fromJson({
    required Map<String, dynamic>? jsonData,
    required T instance,
    String dataKey = 'data',
  }) {
    return BaseListResponseModel<T>(
      currentPage: jsonData?['current_page'],
      total: jsonData?['total_pages'],
      message:jsonData?['message'],
      nextPageUrl: jsonData?['next_page_url'],
      modelList: jsonData?[dataKey] != null
          ? List<T>.from(
        jsonData?[dataKey]['data'].map(
              (model) => instance.fromJson(model),
        ),
      )
          : null,
    );
  }

  final bool? status;
  final String? message;
  final List<T>? modelList;
  final String? nextPageUrl;
  final int? currentPage;
  final int? total;
}
