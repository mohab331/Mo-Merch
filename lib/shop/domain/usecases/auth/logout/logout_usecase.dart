import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class LogoutUsecase
    implements
        BaseUsecase<BaseResponseEntity<LogoutResponseEntity>, NoParameters> {
  LogoutUsecase({
    required this.baseAuthRepo,
    required this.baseLocalStorageRepo,
  });

  BaseAuthRepo baseAuthRepo;
  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<LogoutResponseEntity>>> call(
    NoParameters parameters,
  ) async {
    final response = await baseAuthRepo.logout();
    response.fold((l) {

    }, (logoutResponse) async{
      await _clearUserData();
    });
    return response;
  }

  Future<Either<Failure, bool>> _clearUserData() async {
     return baseLocalStorageRepo.clearUserData();

  }
}
