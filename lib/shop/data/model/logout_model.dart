import '../../domain/entities/logout.dart';

class LogoutResponseModel extends LogoutResponse {
  LogoutResponseModel._(
      {required super.status,
      required super.message,
      required super.logoutData});
  factory LogoutResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      LogoutResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        logoutData: _LogoutDataModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}

class _LogoutDataModel extends LogoutData {
  _LogoutDataModel._({required super.id, required super.token});
  factory _LogoutDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _LogoutDataModel._(
        id: jsonMap['id'],
        token: jsonMap['token'],
      );
}
