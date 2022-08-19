import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/address.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetAddressUseCase implements BaseUsecase<GetAddressResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetAddressUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, GetAddressResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getUserAddress(parameters: parameters,);
  }
}

