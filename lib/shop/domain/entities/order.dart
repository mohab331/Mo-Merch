import 'package:shop_app_clean_architecture/shop/domain/entities/address.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class OrderResponse {
  bool status;
  String message;
  OrderData orderData;
  OrderResponse(
      {required this.status, required this.message, required this.orderData});
}

class OrderData {
  String paymentMethod;
  dynamic cost;
  dynamic vat;
  dynamic discount;
  dynamic points;
  dynamic total;
  List<Product> products;
  int id;
  OrderData(
      {required this.id,
      required this.points,
      required this.total,
      required this.discount,
      required this.paymentMethod,
      required this.vat,
        required this.products,
      required this.cost});
}

class GetOrderResponse {
  bool status;
  String? message;
  GetOrderResponseData getOrderResponseData;
  GetOrderResponse(
      {required this.getOrderResponseData,
      required this.status,
      required this.message});
}

class GetOrderResponseData {
  int currentPage;
  String? nextPageUrl;
  List<GetOrderResponseDataItem> orders;
  GetOrderResponseData(
      {required this.currentPage,
      required this.nextPageUrl,
      required this.orders});
}

class GetOrderResponseDataItem {
  int id;
  dynamic total;
  String date;
  String status;
  GetOrderResponseDataItem(
      {required this.status,
      required this.total,
      required this.id,
      required this.date});
}

class OrderDetailsResponse {
  bool status;
  String? message;
  OrderDetailsResponseData orderDetailsResponseData;
  OrderDetailsResponse(
      {required this.orderDetailsResponseData,
      required this.status,
      required this.message});
}

class OrderDetailsResponseData {
  OrderData orderData;
  String promoCode;
  String date;
  String status;
  AddressData addressData;
  List<OrderDetailsResponseDataItem> orderProducts;
  OrderDetailsResponseData(
      {required this.status,
      required this.orderData,
      required this.addressData,
      required this.date,
      required this.promoCode,
      required this.orderProducts});
}

class OrderDetailsResponseDataItem {
  int id;
  dynamic quantity;
  dynamic price;
  String name;
  String image;
  OrderDetailsResponseDataItem(
      {required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.price});
}
