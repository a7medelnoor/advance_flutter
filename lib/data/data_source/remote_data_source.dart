import 'package:advance_flutter/data/network/app.dart';
import 'package:advance_flutter/data/request/requests.dart';
import 'package:advance_flutter/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImp(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
