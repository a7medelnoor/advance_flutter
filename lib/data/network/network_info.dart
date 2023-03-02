import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {

  InternetConnectionChecker _intenetConnectionChecker;
  NetworkInfoImpl(this._intenetConnectionChecker);
  @override
  Future<bool> get isConnected => _intenetConnectionChecker.hasConnection;

}