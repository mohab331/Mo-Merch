import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for interacting with authentication-related operations.
abstract class BaseAuthRepo {
  /// Registers a new user based on the provided [registerRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [UserResponseEntity] representing the registered user.
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> registerUser({
    required RegisterRequestEntity registerRequestEntity,
  });

  /// Authenticates a user based on the provided [loginRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [UserResponseEntity] representing the authenticated user.
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> loginUser({
    required LoginRequestEntity loginRequestEntity,
  });

  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [LogoutResponseEntity] representing the logout response.
  Future<Either<Failure, BaseResponseEntity<LogoutResponseEntity>>> logout();
}
