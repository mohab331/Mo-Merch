import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';

abstract class BaseUsecase<T,Parameters> {
  Future<Either<Failure,T>> call(Parameters parameters);
}
class NoParameters {
  const NoParameters();
}
class AddUseCaseParameters {
  final String url;
  final String? token;
  final Map<String,dynamic> data;
  const AddUseCaseParameters({required this.data , this.token,required this.url});
}

class DeleteUseCaseParameters {
  final String url;
  final String? token;
  final Map<String,dynamic> data;
  const DeleteUseCaseParameters({required this.data , this.token,required this.url});
}

class GetUseCaseParameters {
  final String url;
  final String? token;
  final int? page;
  const GetUseCaseParameters({ required this.token,required this.url, this.page});
}

class UpdateUseCaseParameters {
  final String url;
  final String token;
  final Map<String,dynamic> data;
  const UpdateUseCaseParameters({required this.data , required this.token,required this.url});
}