import 'package:advance_flutter/app/constants.dart';
import 'package:advance_flutter/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'app.g.dart';
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;

@POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password
    );

@POST("/customers/forgetPassword")
Future<ForgetPasswordResponse> forgetPassword(
    @Field("email") String email);

@POST("/customers/register")
  Future<AuthenticationResponse> registerUser(
    @Field("username") String userName,
    @Field("country_mobile_code") String countryMobile,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
    );
}
