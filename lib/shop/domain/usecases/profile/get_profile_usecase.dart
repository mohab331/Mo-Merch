import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetProfileUseCase
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>, NoParameters> {
  GetProfileUseCase({
    required this.baseProfileRepo,
  });

  BaseProfileRepo baseProfileRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> call(
    NoParameters parameters,
  ) async {
    return await baseProfileRepo.getUserProfile();
  }
}
