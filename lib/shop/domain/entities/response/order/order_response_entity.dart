
class OrderResponseEntity {

  OrderResponseEntity({
    required this.id,
    required this.total,
    required this.orderStatus,
    required this.date,
  });


  final double total;
  final int id;
  final String date;
  final String orderStatus;
}
