import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class RegisterUsecase extends AuthHelper
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            RegisterRequestEntity> {
  RegisterUsecase({
    required this.baseAuthRepo,
    required this.baseLocalStorageRepo,
  }):super(baseLocalStorageRepo: baseLocalStorageRepo);

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
