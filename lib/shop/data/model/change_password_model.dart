import 'package:shop_app_clean_architecture/shop/domain/entities/profile/change_password_response_entity.dart';

class ChangePasswordResponseModel extends ChangePasswordResponse {
  ChangePasswordResponseModel._(
      {required super.status,
      required super.message,
      required super.changePasswordData});
  factory ChangePasswordResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      ChangePasswordResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        changePasswordData:
        _ChangePasswordDataModel.fromJson(jsonMap: jsonMap['data']),
      );
}

class _ChangePasswordDataModel extends ChangePasswordData {
  _ChangePasswordDataModel._({required super.email});
  factory _ChangePasswordDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _ChangePasswordDataModel._(email: jsonMap['email']);
}
