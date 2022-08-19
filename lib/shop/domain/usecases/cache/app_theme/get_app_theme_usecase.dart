import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../repository/base_shop_repository.dart';


class GetAppThemeUseCase{
  BaseShopRepository baseShopRepository;
  GetAppThemeUseCase({required this.baseShopRepository});

  Either<Failure, dynamic> call() {
    return baseShopRepository.getAppThemeMode();
  }
}