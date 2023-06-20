import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetOnBoardingUsecase implements BaseUsecase<bool , NoParameters>{
  GetOnBoardingUsecase({
    required this.baseLocalStorageRepo,
  });

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, bool>> call(NoParameters parameters) async{
    return await baseLocalStorageRepo.getOnBoardingData();
  }


}
