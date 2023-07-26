import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// A repository implementation for handling authentication-related operations.
class AuthRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseAuthRepo {
  AuthRepoImpl({
    required this.baseUserResponseMapper,
    required this.baseLogoutResponseMapper,
    required this.baseShopRemoteDataSource,
    required this.loginRequestMapper,
    required this.registerRequestMapper,
  });

  final BaseResponseMapper<UserResponseModel, UserResponseEntity>
      baseUserResponseMapper;
  final BaseResponseMapper<LogoutResponseModel, LogoutResponseEntity>
      baseLogoutResponseMapper;
  final BaseMapper<LoginRequestModel, LoginRequestEntity> loginRequestMapper;
  final BaseShopRemoteDS baseShopRemoteDataSource;
  final BaseMapper<RegisterRequestModel, RegisterRequestEntity>
      registerRequestMapper;

  /// Logs in a user.
  ///
  /// Returns a [BaseResponseEntity] with the user information if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> loginUser({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    return  executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<UserResponseEntity>>(
      () async {
        final response = await baseShopRemoteDataSource.loginUser(
          loginRequestModel: loginRequestMapper.mapToModel(
            entity: loginRequestEntity,
          ),
        );
        return baseUserResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Logs out the user.
  ///
  /// Returns a [BaseResponseEntity] with the logout information if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<LogoutResponseEntity>>>
      logout() async {
    return  executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<LogoutResponseEntity>>(
      () async {
        final response = await baseShopRemoteDataSource.logout();
        return baseLogoutResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Registers a new user.
  ///
  /// Returns a [BaseResponseEntity] with the registered user information if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> registerUser({
    required RegisterRequestEntity registerRequestEntity,
  }) async {
    return  executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<UserResponseEntity>>(
      () async {
        final response = await baseShopRemoteDataSource.registerUser(
          registerRequestModel: registerRequestMapper.mapToModel(
            entity: registerRequestEntity,
          ),
        );
        return baseUserResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
