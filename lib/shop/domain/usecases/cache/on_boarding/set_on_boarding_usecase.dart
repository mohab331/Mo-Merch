import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SetOnBoardingUsecase implements BaseUsecase<bool, NoParameters> {
  SetOnBoardingUsecase({
    required this.baseLocalStorageRepo,
  });

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, bool>> call(NoParameters parameters) async {
    return await baseLocalStorageRepo.setOnBoarding();
  }
}
