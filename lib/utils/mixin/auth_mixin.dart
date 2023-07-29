import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

mixin AuthMixin {
  Future<Either<Failure, bool>> saveUserData(
    UserResponseEntity user,
  ) async {
    return diInstance.get<BaseLocalStorageRepo>().setUserData(
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
