abstract class Failure {
  const Failure({
    required this.failureMessage,
  });
  final String failureMessage;
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.failureMessage,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.failureMessage,
  });
}
