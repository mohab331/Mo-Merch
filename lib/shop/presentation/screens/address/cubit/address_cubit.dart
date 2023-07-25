import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/address/cubit/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required this.getAddressUseCase,
    required this.addNewAddressUseCase,
  }) : super(AddressInitialState());

  final GetAddressUseCase getAddressUseCase;
  final AddNewAddressUseCase addNewAddressUseCase;

  int currentPage = 1;
  bool hasMoreData = true;
  Map<int , AddressResponseEntity> userAddresses = {};

  void getUserAddresses({
    required int page,
  }) async {
    if (page == 1) {
      userAddresses.clear();
      hasMoreData = true;
    }
    if (hasMoreData == false) {
      return;
    }
    emit(GetAddressLoadingState());
    final response = await getAddressUseCase.call(page);
    response.fold((failure) {
      emit(GetAddressErrorState(
        message: failure.failureMessage,
      ));
    }, (getAddressResponse) {
      currentPage = getAddressResponse.currentPage ?? 1;
      hasMoreData = getAddressResponse.nextPageUrl != null;
        _addUserAddressesToMap(getAddressResponse.entityList);
        emit(const GetAddressSuccessState());
    });
  }

  void _addUserAddressesToMap(List<AddressResponseEntity> addresses){
    for(int i = 0;i<addresses.length;i++){
        _addAddressToMap(addresses[i]);
    }
  }
  void _addAddressToMap(AddressResponseEntity address){
    if(_isAddressInMap(address)) return;
    userAddresses.addAll({address.id:address});
  }
  bool _isAddressInMap(AddressResponseEntity address){
    return userAddresses.containsKey(address.id);
  }
  void _deleteAddressFromMap(AddressResponseEntity address){
    if(!_isAddressInMap(address)) return;
    userAddresses.removeWhere((key, value) => key == address.id);
  }
  void addNewAddress({required AddAddressRequestEntity addressData}) async {
    emit(AddAddressLoadingState());
    final response = await addNewAddressUseCase.call(
      addressData,
    );
    response.fold((failure) {
      emit(AddAddressErrorState(message: failure.failureMessage));
    }, (addressResponse) {
      _addAddressToMap(addressResponse.entity);
      emit(
        AddAddressSuccessState(),
      );
    });
  }

  void deleteAddress({required int addressId}){}
}
