import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shop_app_clean_architecture/core/index.dart';

/// A mixin that provides network connectivity and exception handling functionality.
mixin NetworkAndExceptionHandlingMixin {
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();

  /// Executes a given [tryBlock] function with network connectivity and exception handling.
  ///
  /// The [tryBlock] function should be a future that returns a value of type [T].
  /// This method will handle network connectivity checking and exception handling,
  /// and return an [Either] object representing the success or failure of the operation.
  Future<Either<Failure, T>> executeWithNetworkAndExceptionHandling<T>(
    Future<T> Function() tryBlock,
  ) async {
    try {
      await _checkNetworkConnectivity();
      final response = await tryBlock();
      return Right(response);
    } on ServerException catch (error) {
      return Left(_handleCatchException(error));
    }
  }

  /// Checks the network connectivity and throws a [ServerException] if there is no network connection available.
  Future<void> _checkNetworkConnectivity() async {
    var connectivityResult = await internetConnectionChecker.hasConnection;
    if (!connectivityResult) {
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          jsonMap: {
            'message': 'No network connection available.',
          },
        ),
      );
    }
  }

  /// Handles the caught [error] and returns a [Failure] object based on the error.
  Failure _handleCatchException(error) {
    return ServerFailure(
      failureMessage: error.errorModel.errorMessage ?? R.strings.unKnownError,
    );
  }
}
