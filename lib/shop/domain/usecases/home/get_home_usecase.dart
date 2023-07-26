import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetHomeUsecase
    implements
        BaseUsecase<BaseResponseEntity<HomeResponseEntity>, NoParameters> {
  GetHomeUsecase({required this.baseHomeRepo});

  BaseHomeRepo baseHomeRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<HomeResponseEntity>>> call(
    NoParameters parameters,
  ) async {
    return baseHomeRepo.getHomeData();
  }
}
