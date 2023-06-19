class ProductOrderResponseEntity {

  const ProductOrderResponseEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });
  final int id;
  final int quantity;
  final double price;
  final String name;
  final String image;
}
