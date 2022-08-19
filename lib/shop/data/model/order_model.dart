import 'package:shop_app_clean_architecture/shop/data/model/address_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/product_model.dart';

import '../../domain/entities/order.dart';

class OrderResponseModel extends OrderResponse {
  OrderResponseModel._(
      {required super.status,
      required super.message,
      required super.orderData});
  factory OrderResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      OrderResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        orderData: _OrderDataModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}
class GetOrderResponseModel extends GetOrderResponse {
  GetOrderResponseModel._(
      {required super.getOrderResponseData,
        required super.status,
        required super.message});
  factory GetOrderResponseModel.fromJson(
      {required Map<String, dynamic> jsonMap}) =>
      GetOrderResponseModel._(
          getOrderResponseData:
          _GetOrderResponseDataModel.fromJson(jsonMap: jsonMap['data']),
          status: jsonMap['status'],
          message: jsonMap['message']);
}
class OrderDetailsResponseModel extends OrderDetailsResponse {
  OrderDetailsResponseModel(
      {required super.orderDetailsResponseData,
        required super.status,
        required super.message});
  factory OrderDetailsResponseModel.fromJson(
      {required Map<String, dynamic> jsonMap}) =>
      OrderDetailsResponseModel(
          orderDetailsResponseData:
          _OrderDetailsResponseDataModel.fromJson(jsonMap: jsonMap['data']),
          status: jsonMap['status'],
          message: jsonMap['message']);
}

class _OrderDataModel extends OrderData {
  _OrderDataModel._(
      {required super.id,
      required super.points,
        required super.products,
      required super.total,
      required super.discount,
      required super.paymentMethod,
      required super.vat,
      required super.cost});
  factory _OrderDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _OrderDataModel._(
        id: jsonMap['id'],
        points: jsonMap['points'],
        total: jsonMap['total'],
        discount: jsonMap['discount'],
        paymentMethod: jsonMap['payment_method'],
        vat: jsonMap['vat'],
        cost: jsonMap['cost'],
        products:jsonMap['products'] == null?[]: (jsonMap['products'] as List).map((e) => ProductModel.fromJson(jsonMap: e)).toList(),
      );
}
class _GetOrderResponseDataModel extends GetOrderResponseData {
  _GetOrderResponseDataModel._(
      {required super.currentPage,
      required super.nextPageUrl,
      required super.orders});
  factory _GetOrderResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _GetOrderResponseDataModel._(
          currentPage: jsonMap['current_page'],
          nextPageUrl: jsonMap['next_page_url'],
          orders: (jsonMap['data'] as List).map((e) {
            return _GetOrderResponseDataItemModel.fromJson(jsonMap: e);
          }).toList());
}
class _GetOrderResponseDataItemModel extends GetOrderResponseDataItem {
  _GetOrderResponseDataItemModel._(
      {required super.status,
      required super.total,
      required super.id,
      required super.date});
  factory _GetOrderResponseDataItemModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _GetOrderResponseDataItemModel._(
        status: jsonMap['status'],
        total: jsonMap['total'],
        id: jsonMap['id'],
        date: jsonMap['date'],
      );
}
class _OrderDetailsResponseDataModel extends OrderDetailsResponseData {
  _OrderDetailsResponseDataModel._(
      {required super.status,
      required super.orderData,
      required super.addressData,
      required super.date,
      required super.promoCode,
      required super.orderProducts});
  factory _OrderDetailsResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _OrderDetailsResponseDataModel._(
          status: jsonMap['status'],
          orderData: _OrderDataModel.fromJson(jsonMap: jsonMap),
          addressData: AddressDataModel.fromJson(jsonMap: jsonMap['address']),
          date: jsonMap['date'],
          promoCode: jsonMap['promo_code'],
          orderProducts: (jsonMap['products'] as List).map((e) {
            return _OrderDetailsResponseDataItemModel.fromJson(jsonMap: e);
          }).toList());
}
class _OrderDetailsResponseDataItemModel extends OrderDetailsResponseDataItem {
  _OrderDetailsResponseDataItemModel._(
      {required super.id,
      required super.image,
      required super.name,
      required super.quantity,
      required super.price});
  factory _OrderDetailsResponseDataItemModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _OrderDetailsResponseDataItemModel._(
          id: jsonMap['id'],
          image: jsonMap['image'],
          name: jsonMap['name'],
          quantity: jsonMap['quantity'],
          price: jsonMap['price']);
}
