import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/utils/index.dart';

class RegisterUsecase with AuthMixin
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            RegisterRequestEntity> {
  RegisterUsecase({
    required this.baseAuthRepo,
    required this.baseLocalStorageRepo,
  });

  BaseAuthRepo baseAuthRepo;
  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> call(
    RegisterRequestEntity registerRequestEntity,
  ) async {
    final response = await baseAuthRepo.registerUser(
      registerRequestEntity: registerRequestEntity,
    );
    response.fold((failure) {}, (registerResponse) async {
      await saveUserData(registerResponse.entity);
    });
    return response;
  }

}
