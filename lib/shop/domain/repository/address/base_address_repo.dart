import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for interacting with address-related operations.
abstract class BaseAddressRepo {
  /// Adds a new address based on the provided [addAddressRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [AddressResponseEntity].
  Future<Either<Failure, BaseResponseEntity<AddressResponseEntity>>>
      addNewAddress({
    required AddAddressRequestEntity addAddressRequestEntity,
  });

  /// Retrieves the user's addresses.
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseListResponseEntity] of [AddressResponseEntity].
  Future<Either<Failure, BaseListResponseEntity<AddressResponseEntity>>>
      getUserAddress({
    required int page,
  });
}
