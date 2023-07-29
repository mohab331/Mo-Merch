import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/utils/index.dart';

class LoginUsecase with AuthMixin
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            LoginRequestEntity>  {
  LoginUsecase({
    required this.baseAuthRepo,
    required this.baseLocalStorageRepo,
  });

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
