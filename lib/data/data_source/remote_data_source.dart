import 'package:advance_flutter/data/network/app.dart';
import 'package:advance_flutter/data/request/requests.dart';
import 'package:advance_flutter/data/response/responses.dart';

import '../../domain/model/model.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> registerUser(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgetPassword(String email);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();

}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImp(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgetPassword(String email) async{
    return await _appServiceClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> registerUser(RegisterRequest registerRequest) async {
    return await _appServiceClient.registerUser( registerRequest.userName,
        registerRequest.countryMobileCode, registerRequest.mobileNumber, registerRequest.email, registerRequest.password, "");
  }

  @override
  Future<HomeResponse> getHomeData() async{
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    return await _appServiceClient.getStoreDetailsData();

  }

}
