import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';

/// Abstract base class for use cases in the application.
///
/// [T] represents the expected result type of the use case.
/// [Parameters] represents the input parameters required for the use case.
abstract class BaseUsecase<T, Parameters> {
  /// Executes the use case with the given [parameters].
  ///
  /// Returns a [Future] that resolves to an [Either] object representing the
  /// result of the use case execution.
  ///
  /// The [Either] object contains either a [Failure] indicating an error occurred,
  /// or the result [T] if the use case executed successfully.
  Future<Either<Failure, T>> call(Parameters parameters);
}

/// Represents a marker class for use cases that don't require any parameters.
///
/// This class can be used as a parameter for use cases that don't expect any input parameters.
class NoParameters {
  const NoParameters();
}
