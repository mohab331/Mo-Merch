import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for interacting with user profile-related operations.
abstract class BaseProfileRepo {
  /// Retrieves the user profile.
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [UserResponseEntity] representing the user profile.
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>>
      getUserProfile();

  /// Updates the user profile based on the provided [updateProfileRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [UserResponseEntity] representing the updated user profile.
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>>
      updateUserProfile({
    required UpdateProfileRequestEntity updateProfileRequestEntity,
  });

  /// Changes the user password based on the provided [changePasswordRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [ChangePasswordResponseEntity] representing the change password response.
  Future<Either<Failure, BaseResponseEntity<ChangePasswordResponseEntity>>>
      changeUserPassword({
    required ChangePasswordRequestEntity changePasswordRequestEntity,
  });
}
