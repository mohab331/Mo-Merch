import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/address.dart';
import '../../repository/base_shop_repository.dart';

class UpdateAddressUseCase implements BaseUsecase<AddressResponse ,UpdateUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  UpdateAddressUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, AddressResponse>> call(UpdateUseCaseParameters parameters) async{
    return await baseShopRepository.updateAddress(parameters: parameters);
  }
}

