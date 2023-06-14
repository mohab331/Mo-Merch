class BaseListResponseEntity<T> {
  const BaseListResponseEntity({
    required this.entityList,
    this.status,
    this.message,
    this.currentPage,
    this.nextPageUrl,
    this.total,
  });

  final bool? status;
  final String? message;
  final List<T> entityList;
  final String? nextPageUrl;
  final int? currentPage;
  final int? total;
}
