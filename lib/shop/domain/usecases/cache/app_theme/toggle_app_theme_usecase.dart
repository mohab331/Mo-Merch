import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../../repository/base_shop_repository.dart';


class ToggleAppThemeUseCase implements BaseUsecase<bool ,ToggleAppThemeUsecaseParameters >{
  BaseShopRepository baseShopRepository;
  ToggleAppThemeUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, bool>> call(ToggleAppThemeUsecaseParameters parameters) async{
    return await baseShopRepository.toggleAppTheme(parameters: parameters);
  }
}

class ToggleAppThemeUsecaseParameters{
  final bool theme;
  ToggleAppThemeUsecaseParameters({required this.theme});
}
