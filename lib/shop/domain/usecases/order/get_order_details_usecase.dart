import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetOrderDetailsUsecase implements BaseUsecase<OrderDetailsResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetOrderDetailsUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, OrderDetailsResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getOrderDetails(parameters: parameters);
  }
}

