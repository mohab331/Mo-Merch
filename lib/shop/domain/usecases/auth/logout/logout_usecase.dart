import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class LogoutUsecase
    implements
        BaseUsecase<BaseResponseEntity<LogoutResponseEntity>, NoParameters> {
  LogoutUsecase({
    required this.baseAuthRepo,
  });

  BaseAuthRepo baseAuthRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<LogoutResponseEntity>>> call(
    NoParameters parameters,
  ) async {
    return await baseAuthRepo.logout();
  }
}
