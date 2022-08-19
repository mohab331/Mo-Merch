import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetworkChecker{
  Future<bool> get isConnected;
}
class NetworkCheckerImplementation implements NetworkChecker{
final InternetConnectionChecker _internetConnectionChecker;
NetworkCheckerImplementation(this._internetConnectionChecker);
  @override

  Future<bool> get isConnected async=> await _internetConnectionChecker.hasConnection;
}