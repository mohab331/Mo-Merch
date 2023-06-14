import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class ToggleAppThemeUseCase
    implements BaseUsecase<bool, AppThemeRequestEntity> {
  ToggleAppThemeUseCase({
    required this.baseLocalStorageRepo,
  });

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, bool>> call(
    AppThemeRequestEntity appThemeRequestEntity,
  ) async {
    return await baseLocalStorageRepo.toggleAppTheme(
      appThemeRequestEntity: appThemeRequestEntity,
    );
  }
}
