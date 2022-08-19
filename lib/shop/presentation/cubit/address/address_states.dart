abstract class AddressStates{}

class AddressInitialState extends AddressStates{}

class GetAddressSuccessState extends AddressStates{}
class GetAddressLoadingState extends AddressStates{}
class GetAddressErrorState extends AddressStates{}

class AddAddressSuccessState extends AddressStates{
  final String message;
  AddAddressSuccessState({required this.message});
}
class AddAddressLoadingState extends AddressStates{}
class AddAddressErrorState extends AddressStates{
  final String errorMessage;
  AddAddressErrorState({required this.errorMessage});
}