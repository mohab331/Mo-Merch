
class AddressResponse {
  bool status;
  String message;

  AddressData addressData;
  AddressResponse({required this.status , required this.message , required this.addressData});
}
class GetAddressResponse{
  bool status;
  String? message;
  GetAddressResponseData getAddressResponseData;
  GetAddressResponse({required this.status , required this.message , required this.getAddressResponseData,});
}
class GetAddressResponseData{
  int currentPage;
  String? nextPageUrl;
  int total;
  List<AddressData> userAddresses;
  GetAddressResponseData({required this.currentPage , required this.nextPageUrl , required this.total , required this.userAddresses});
}
class AddressData {
  int id;
  String name;
  String city;
  String region;
  String details;
  dynamic latitude;
  dynamic longitude;
  String notes;

  AddressData(
      {required this.id,
      required this.name,
      required this.city,
      required this.region,
      required this.details,
      required this.notes}) {
    latitude = 0.0;
    longitude = 0.0;
  }
}
