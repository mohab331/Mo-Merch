class ErrorModel {
  const ErrorModel._({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson({required Map<String, dynamic>? jsonMap}) =>
      ErrorModel._(status: jsonMap?['status'], errorMessage: jsonMap?['message']);
  final bool? status;
  final String? errorMessage;
}
