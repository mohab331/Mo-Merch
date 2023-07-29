import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class AuthHelper {
  AuthHelper({
    required this.baseLocalStorageRepo,
  });
  final BaseLocalStorageRepo baseLocalStorageRepo;
  Future<Either<Failure, bool>> saveUserData(
    UserResponseEntity user,
  ) async {
    return baseLocalStorageRepo.setUserData(
      saveUserDataRequestEntity: SaveUserDataRequestEntity(
        token: user.token,
        name: user.name,
        phone: user.phone,
        id: user.id,
        email: user.email,
      ),
    );
  }
}
