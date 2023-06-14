class ProductOrderResponseEntity {
  final int id;
  final int quantity;
  final double price;
  final String name;

  const ProductOrderResponseEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });
}
