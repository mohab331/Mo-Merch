class BaseResponseEntity<T> {
  BaseResponseEntity({
    required this.entity,
    this.message,
    this.status,
  });

  final bool? status;
  final String? message;
  final T entity;
}
