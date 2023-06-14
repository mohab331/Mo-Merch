import 'package:shop_app_clean_architecture/shop/domain/entities/address/address_response_entity.dart';

class AddressResponseModel extends AddressResponse {
  AddressResponseModel._(
      {required super.status,
      required super.message,
      required super.addressData});
  factory AddressResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      AddressResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        addressData: AddressDataModel.fromJson(jsonMap: jsonMap['data']),
      );
}
class GetAddressResponseModel extends GetAddressResponse {
  GetAddressResponseModel._(
      {required super.status,
      required super.message,
      required super.getAddressResponseData});
  factory GetAddressResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      GetAddressResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        getAddressResponseData:
            _GetAddressResponseDataModel.fromJson(jsonMap: jsonMap['data']),
      );
}

class _GetAddressResponseDataModel extends GetAddressResponseData {
  _GetAddressResponseDataModel._(
      {required super.currentPage,
      required super.nextPageUrl,
      required super.total,
      required super.userAddresses});
  factory _GetAddressResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _GetAddressResponseDataModel._(
          currentPage: jsonMap['current_page'],
          nextPageUrl: jsonMap['next_page_url'],
          total: jsonMap['total'],
          userAddresses: (jsonMap['data'] as List).map((e) {
            return AddressDataModel.fromJson(jsonMap: e);
          }).toList());
}
class AddressDataModel extends AddressData {
  AddressDataModel._(
      {required super.id,
      required super.name,
      required super.city,
      required super.region,
      required super.details,
      required super.notes});
  factory AddressDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      AddressDataModel._(
        id: jsonMap['id'],
        name: jsonMap['name'],
        city: jsonMap['city'],
        region: jsonMap['region'],
        details: jsonMap['details'],
        notes: jsonMap['notes'],
      );
}
