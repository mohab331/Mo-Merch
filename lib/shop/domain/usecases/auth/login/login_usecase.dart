import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/repository/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/auth/auth_helper.dart';

class LoginUsecase extends AuthHelper
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            LoginRequestEntity>  {
  LoginUsecase({
    required this.baseAuthRepo,
    required this.baseLocalStorageRepo,
  }) : super(baseLocalStorageRepo: baseLocalStorageRepo,);

  BaseAuthRepo baseAuthRepo;
  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> call(
    LoginRequestEntity loginRequestEntity,
  ) async {
    final response = await baseAuthRepo.loginUser(
      loginRequestEntity: loginRequestEntity,
    );
    response.fold((l) {}, (r) async {
      if (loginRequestEntity.rememberMe) {
        await saveUserData(r.entity,);
      }
    });
    return response;
  }




}
