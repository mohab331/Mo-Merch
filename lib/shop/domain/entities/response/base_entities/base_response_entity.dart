class BaseResponseEntity<T> {
  BaseResponseEntity({
    this.message,
    this.status,
    required this.entity,
  });

  final bool? status;
  final String? message;
  final T entity;
}
