import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../repository/base_shop_repository.dart';


class GetCachedUserDataUsecase{
  BaseShopRepository baseShopRepository;
  GetCachedUserDataUsecase({required this.baseShopRepository});

  Either<Failure, dynamic> call() {
    return  baseShopRepository.getUserData();
  }
}