import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class BaseResponseModel<T extends JsonConverter> {
  BaseResponseModel({
    required this.model,
    this.message,
    this.status,
  });

  factory BaseResponseModel.fromJson({
    required Map<String, dynamic> jsonMap,
    required T modelInstance,
  }) =>
      BaseResponseModel<T>(
        model: modelInstance.fromJson(
          jsonMap['data'],
        ),
        status: jsonMap['status'],
        message: jsonMap['message'],
      );

  final bool? status;
  final String? message;
  final T? model;
}
