import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class RegisterUsecase
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            RegisterRequestEntity> {
  RegisterUsecase({required this.baseAuthRepo});

  BaseAuthRepo baseAuthRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> call(
    RegisterRequestEntity registerRequestEntity,
  ) async {
    return await baseAuthRepo.registerUser(
      registerRequestEntity: registerRequestEntity,
    );
  }
}
