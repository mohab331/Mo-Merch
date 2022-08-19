import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/address.dart';
import 'package:shop_app_clean_architecture/shop/domain/repository/base_shop_repository.dart';

class AddNewAddressUseCase implements BaseUsecase<AddressResponse ,AddUseCaseParameters >{
BaseShopRepository baseShopRepository;
AddNewAddressUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, AddressResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.addNewAddress(parameters: parameters);
  }
}

