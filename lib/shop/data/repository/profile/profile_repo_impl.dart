import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// Implementation of the `BaseProfileRepo` interface.
///
/// This class handles user profile-related operations such as changing the password,
/// retrieving the user profile, and updating the user profile.
class ProfileRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseProfileRepo {

  /// Constructs an instance of `ProfileRepoImpl` with the required dependencies.
  ///
  /// The [baseShopRemoteDS] is the remote data source for the shop.
  /// The [changePasswordRequestMapper] is the mapper for converting change password request entities to models.
  /// The [baseChangePasswordResponseMapper] is the mapper for converting change password response models to entities.
  /// The [baseUserResponseMapper] is the mapper for converting user response models to entities.
  /// The [updateProfileRequestMapper] is the mapper for converting update profile request entities to models.
  ProfileRepoImpl({
    required this.baseShopRemoteDS,
    required this.changePasswordRequestMapper,
    required this.baseChangePasswordResponseMapper,
    required this.baseUserResponseMapper,
    required this.updateProfileRequestMapper,
  });
  final BaseShopRemoteDS baseShopRemoteDS;
  final BaseMapper<ChangePasswordRequestModel, ChangePasswordRequestEntity>
      changePasswordRequestMapper;
  final BaseResponseMapper<ChangePasswordResponseModel,
      ChangePasswordResponseEntity> baseChangePasswordResponseMapper;
  final BaseResponseMapper<UserResponseModel, UserResponseEntity>
      baseUserResponseMapper;
  final BaseMapper<UpdateProfileRequestModel, UpdateProfileRequestEntity>
      updateProfileRequestMapper;

  /// Changes the user password.
  ///
  /// This method sends a change password request to the remote data source using the `changeUserPassword` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseResponseEntity<ChangePasswordResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseResponseEntity<ChangePasswordResponseEntity>>>
      changeUserPassword({
    required ChangePasswordRequestEntity changePasswordRequestEntity,
  }) async {
    return  executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<ChangePasswordResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.changeUserPassword(
          changePasswordRequestModel: changePasswordRequestMapper.mapToModel(
            entity: changePasswordRequestEntity,
          ),
        );
        return baseChangePasswordResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Retrieves the user profile.
  ///
  /// This method sends a request to the remote data source using the `getUserProfile` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseResponseEntity<UserResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>>
      getUserProfile() async {
    return executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<UserResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getUserProfile();
        return baseUserResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Updates the user profile.
  ///
  /// This method sends an update profile request to the remote data source using the `updateUserProfile` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseResponseEntity<UserResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>>
      updateUserProfile({
    required UpdateProfileRequestEntity updateProfileRequestEntity,
  }) async {
    return executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<UserResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.updateUserProfile(
          updateProfileRequestModel: updateProfileRequestMapper.mapToModel(
            entity: updateProfileRequestEntity,
          ),
        );
        return baseUserResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
