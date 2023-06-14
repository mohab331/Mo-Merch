import 'package:shop_app_clean_architecture/shop/data/model/product_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart/cart_response_entity.dart';

class CartResponseModel extends CartResponse {
  CartResponseModel._(
      {required super.message,
      required super.cartResponseData,
      required super.status});
  factory CartResponseModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      CartResponseModel._(
          message: jsonMap['message'],
          cartResponseData:
              _CartResponseDataModel.fromJson(jsonMap: jsonMap['data']),
          status: jsonMap['status']);
}

class _CartResponseDataModel extends CartResponseData {
  _CartResponseDataModel._({required super.total, required super.cartItems});
  factory _CartResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _CartResponseDataModel._(
          total: jsonMap['total'],
          cartItems: (jsonMap['cart_items'] as List).isEmpty
              ? []
              : (jsonMap['cart_items'] as List).map((e) {
                  return _CartDataModel.fromJson(jsonMap: e);
                }).toList());
}

class _CartDataModel extends CartData {
  _CartDataModel._(
      {required super.product, required super.id, required super.quantity});
  factory _CartDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _CartDataModel._(
          product: ProductModel.fromJson(jsonMap: jsonMap['product']),
          id: jsonMap['id'],
          quantity: jsonMap['quantity']);
}

class CartUpdateResponseModel extends CartUpdateResponse {
  CartUpdateResponseModel._(
      {required super.status,
      required super.message,
      required super.cartUpdateResponseData});
  factory CartUpdateResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      CartUpdateResponseModel._(
          status: jsonMap['status'],
          message: jsonMap['message'],
          cartUpdateResponseData:
              _CartUpdateResponseDataModel.fromJson(jsonMap: jsonMap['data']));
}

class _CartUpdateResponseDataModel extends CartUpdateResponseData {
  _CartUpdateResponseDataModel._(
      { required super.total});

  factory _CartUpdateResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _CartUpdateResponseDataModel._(
          total: jsonMap['total']);
}
