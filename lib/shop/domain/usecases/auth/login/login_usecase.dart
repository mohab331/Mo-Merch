import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/repository/index.dart';

class LoginUsecase
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            LoginRequestEntity> {
  LoginUsecase({
    required this.baseAuthRepo,
  });

  BaseAuthRepo baseAuthRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> call(
    LoginRequestEntity loginRequestEntity,
  ) async {
    return await baseAuthRepo.loginUser(
      loginRequestEntity: loginRequestEntity,
    );
  }
}
