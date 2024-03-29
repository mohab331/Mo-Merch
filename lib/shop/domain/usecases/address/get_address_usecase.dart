import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetAddressUseCase
    implements BaseUsecase<BaseListResponseEntity<AddressResponseEntity>, int> {
  GetAddressUseCase({
    required this.baseAddressRepo,
  });

  BaseAddressRepo baseAddressRepo;

  @override
  Future<Either<Failure, BaseListResponseEntity<AddressResponseEntity>>> call(
    int page,
  ) async {
    return baseAddressRepo.getUserAddress(
      page: page,
    );
  }
}
