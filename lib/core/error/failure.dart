
abstract class Failure{
  final String failureMessage;
  const Failure({required this.failureMessage});

}

class ServerFailure extends Failure{
  const ServerFailure({required super.failureMessage});
}

class CacheFailure extends Failure{
  const CacheFailure({required super.failureMessage});
}