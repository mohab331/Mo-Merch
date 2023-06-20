import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetCachedUserDataUsecase implements BaseUsecase<UserDataResponseEntity , NoParameters>{
  GetCachedUserDataUsecase({required this.baseLocalStorageRepo});

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, UserDataResponseEntity>> call(NoParameters parameters) async{
    return await baseLocalStorageRepo.getUserData();
  }


}
