import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';

/// A repository implementation for handling address-related operations.
class AddressRepoImpl with NetworkAndExceptionHandlingMixin implements BaseAddressRepo {
  AddressRepoImpl({
    required this.baseShopRemoteDataSource,
    required this.baseListResponseMapper,
    required this.baseResponseMapper,
    required this.addAddressRequestMapper,
  });

  final BaseShopRemoteDS baseShopRemoteDataSource;
  final BaseListResponseMapper<AddressResponseModel, AddressResponseEntity> baseListResponseMapper;
  final BaseResponseMapper<AddressResponseModel, AddressResponseEntity> baseResponseMapper;
  final AddAddressRequestMapper addAddressRequestMapper;

  /// Adds a new address.
  ///
  /// Returns a [BaseResponseEntity] with the added address if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<AddressResponseEntity>>> addNewAddress({
    required AddAddressRequestEntity addAddressRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<BaseResponseEntity<AddressResponseEntity>>(
          () async {
        final response = await baseShopRemoteDataSource.addNewAddress(
          addAddressRequestModel: addAddressRequestMapper.mapToModel(
            entity: addAddressRequestEntity,
          ),
        );
        return baseResponseMapper.mapToEntity(model: response);
      },
    );
  }

  /// Retrieves the user's address.
  ///
  /// Returns a [BaseListResponseEntity] with the user's address list if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseListResponseEntity<AddressResponseEntity>>> getUserAddress() async {
    return await executeWithNetworkAndExceptionHandling<BaseListResponseEntity<AddressResponseEntity>>(
          () async {
        final response = await baseShopRemoteDataSource.getUserAddress();
        return baseListResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
