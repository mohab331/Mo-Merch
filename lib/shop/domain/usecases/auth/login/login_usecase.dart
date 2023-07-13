import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/repository/index.dart';

class LoginUsecase
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            LoginRequestEntity> {
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
        await _saveUserData(
          r.entity,
        );
      }
    });
    return response;
  }

  Future<Either<Failure, bool>> _saveUserData(
    UserResponseEntity user,
  ) async {
    return baseLocalStorageRepo.setUserData(
      saveUserDataRequestEntity: SaveUserDataRequestEntity(
        token: user.token,
        name: user.name, phone: user.phone,id:user.id ,email: user.email,
      ),
    );
  }
}
