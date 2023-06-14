import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddNewAddressUseCase
    implements
        BaseUsecase<BaseResponseEntity<AddressResponseEntity>,
            AddAddressRequestEntity> {
  AddNewAddressUseCase({required this.baseAddressRepo});

  final BaseAddressRepo baseAddressRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<AddressResponseEntity>>> call(
    AddAddressRequestEntity addAddressRequestEntity,
  ) async {
    return await baseAddressRepo.addNewAddress(
      addAddressRequestEntity: addAddressRequestEntity,
    );
  }
}
