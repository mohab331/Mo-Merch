import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class CartResponse{
  bool status;
  String? message;
  CartResponseData cartResponseData;
  CartResponse({required this.message , required this.cartResponseData , required this.status});
}
class CartResponseData{
  List<CartData> cartItems;
  dynamic total;
  CartResponseData({required this.total , required this.cartItems});
}
class CartData{
  int id;
  dynamic quantity;
  Product product;
  CartData({required this.product , required this.id , required this.quantity});
}

class CartUpdateResponse{
  bool status;
  String message;
  CartUpdateResponseData cartUpdateResponseData;

  CartUpdateResponse({required this.status , required this.message , required this.cartUpdateResponseData});
}
class CartUpdateResponseData{

  dynamic total;

  CartUpdateResponseData({required this.total,});
}
