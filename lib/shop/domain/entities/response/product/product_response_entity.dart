class ProductResponseEntity {
  ProductResponseEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.image,
    required this.inCart,
    required this.images,
    required this.description,
    required this.inFavorites,
    required this.oldPrice,
  });

  final int id;
  final String name;
  final double price;
  final double oldPrice;
  final double discount;
  final String image;
  final String? description;
  final List<String>? images;
  final bool? inFavorites;
  final bool? inCart;
}
