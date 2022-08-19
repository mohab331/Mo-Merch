class Product{
  int id;
  String name;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Product({
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
}