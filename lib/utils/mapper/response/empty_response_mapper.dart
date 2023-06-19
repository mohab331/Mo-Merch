import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class EmptyResponseMapper implements BaseMapper<EmptyResponseModel , EmptyResponseEntity>{
  @override
  EmptyResponseEntity mapToEntity({required EmptyResponseModel? model}) {
    return const EmptyResponseEntity();
  }

  @override
  EmptyResponseModel mapToModel({required EmptyResponseEntity entity}) {
   return const EmptyResponseModel();
  }

}