import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/address.dart';
import '../../repository/base_shop_repository.dart';

class DeleteAddressUseCase implements BaseUsecase<AddressResponse ,DeleteUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  DeleteAddressUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, AddressResponse>> call(DeleteUseCaseParameters parameters) async{
    return await baseShopRepository.deleteAddress(parameters: parameters);
  }
}

