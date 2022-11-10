import 'package:data_connection_checker/data_connection_checker.dart'
if (dart.library.html) "data_connection_checker_web.dart" as dc;

abstract class NetworkInfo{
  Future<bool> get isConnected; 
}
class NetworkInfoImpl implements NetworkInfo {
  final dc.DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}