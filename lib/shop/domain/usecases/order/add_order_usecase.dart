import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class AddOrderUseCase implements BaseUsecase<OrderResponse , AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  AddOrderUseCase({required this.baseShopRepository});
  @override
  Future<Either<Failure, OrderResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.createOrder(parameters: parameters);
  }
}

