class ErrorModel {
  const ErrorModel._({required this.status, required this.errorMessage,this.statusCode,});
  factory ErrorModel.fromJson({required Map<String, dynamic>? jsonMap}) =>
      ErrorModel._(
          status: jsonMap?['status'], errorMessage: jsonMap?['message'],statusCode:jsonMap?['statusCode']);
  final bool? status;
  final String? errorMessage;
  final int? statusCode;
}
