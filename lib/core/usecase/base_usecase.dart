import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';

abstract class BaseUsecase<T,Parameters> {
  Future<Either<Failure,T>> call(Parameters parameters);
}
class NoParameters {
  const NoParameters();
}