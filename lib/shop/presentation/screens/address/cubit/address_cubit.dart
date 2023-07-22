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
  List<AddressResponseEntity> userAddresses = [];

  void getUserAddresses({
    required int page,
  }) async {
    if (page == 1) {
      userAddresses = [];
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
      userAddresses.addAll(getAddressResponse.entityList);
      emit(GetAddressSuccessState(
        addressResponse: userAddresses,
      ));
    });
  }

  void addNewAddress({required AddAddressRequestEntity addressData}) async {
    emit(AddAddressLoadingState());
    final response = await addNewAddressUseCase.call(
      addressData,
    );
    response.fold((failure) {
      emit(AddAddressErrorState(message: failure.failureMessage));
    }, (addressResponse) {
      userAddresses.add(addressResponse.entity);
      emit(
        GetAddressSuccessState(
          addressResponse: userAddresses,
        ),
      );
    });
  }
}
