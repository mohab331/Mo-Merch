import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/address/address_response_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/address/add_address_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/address/get_address_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/check_out/check_out_cubit.dart';

class AddressCubit extends Cubit<AddressStates>{
  AddressCubit():super(AddressInitialState());
  static AddressCubit get(context) => BlocProvider.of(context);
  List<AddressData> userAddressList = [];
  int currentAddressPage = 1;
  bool hasMoreAddressData = true;
  AddressData? addedAddressData;


  void getUserAddresses(BuildContext context) async{
    if(currentAddressPage == 1){
      userAddressList = [];
      hasMoreAddressData = true;
    }
    if(hasMoreAddressData == false){
      return;
    }
    emit(GetAddressLoadingState());
    final response = await di.sl<GetAddressUseCase>().call(GetUseCaseParameters(token: AppCubit.get(context).getUserToken(), url: Endpoints.address,page: currentAddressPage));
    response.fold((failure){
      emit(GetAddressErrorState());
    }, (getAddressResponse){
      userAddressList.addAll(getAddressResponse.getAddressResponseData.userAddresses);
      currentAddressPage = getAddressResponse.getAddressResponseData.currentPage;
      hasMoreAddressData = getAddressResponse.getAddressResponseData.nextPageUrl != null?true:false;
      emit(GetAddressSuccessState());
    });
  }
  void addNewAddress(BuildContext context,{required Map<String,dynamic>data})async{
    emit(AddAddressLoadingState());
    final response = await di.sl<AddNewAddressUseCase>().call(AddUseCaseParameters(data: data, url: Endpoints.address,token: AppCubit.get(context).getUserToken()));
    response.fold((failure){
      emit(AddAddressErrorState(errorMessage: failure.failureMessage));
    }, (addressResponse){
      addedAddressData = addressResponse.addressData;
      print(addedAddressData!.id);
      CheckOutCubit.get(context).addressId = addedAddressData!.id;
      emit(AddAddressSuccessState(message: addressResponse.message));
    });
  }
}