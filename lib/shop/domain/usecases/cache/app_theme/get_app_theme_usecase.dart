import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/enums/app_theme_enum.dart';

class GetAppThemeUseCase implements BaseUsecase<AppThemeEnum,NoParameters>{
  GetAppThemeUseCase({required this.baseLocalStorageRepo,});

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, AppThemeEnum>> call(NoParameters parameters) async{
    return baseLocalStorageRepo.getAppThemeMode();
  }


}
