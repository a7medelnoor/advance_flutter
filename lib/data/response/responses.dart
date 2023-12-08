import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numberOfNotifications")
  int? numberOfNotifications;
  CustomerResponse(this.id, this.name, this.numberOfNotifications);
  // From json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);
  // To json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);
  // From json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) => _$ContactsResponseFromJson(json);
  // To json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}
@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

// from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgetPasswordResponse(this.support);

  // to json
   Map<String, dynamic> toJson()  => _$ForgetPasswordResponseToJson(this);
  // from json
factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
    _$ForgetPasswordResponseFromJson(json);
}

@JsonSerializable()
class RegisterUserResponse extends BaseResponse {
  @JsonKey(name: "email")
  String? email;

  RegisterUserResponse(this.email);

  // To json
  Map<String, dynamic> toJson() => _$RegisterUserResponseToJson(this);

  // From json
  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserResponseFromJson(json);
}

@JsonSerializable()
class ServiceResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse(this.id, this.title, this.image);
  // to json
   Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);

  // from json
   factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
       _$ServiceResponseFromJson(json);
}

@JsonSerializable()
class BannersResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  BannersResponse(this.id, this.link, this.title, this.image);
  // to json
  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);

  // from json
  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
}

@JsonSerializable()
class StoreResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoreResponse(this.id, this.title, this.image);
  // to json
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);

  // from json
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'banners')
  List<BannersResponse>? banners;
  @JsonKey(name: 'stores')
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);
  // to json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  // from json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse(this.data);
  // to json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  // from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
@JsonSerializable()
class StoreDetails extends BaseResponse{
  @JsonKey(name: 'data')
  StoreDataResponse? data;

  StoreDetails(this.data);
  // to json
  Map<String, dynamic> toJson() => _$StoreDetailsToJson(this);

  // from json
  factory StoreDetails.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsFromJson(json);
}
@JsonSerializable()
class StoreDataResponse extends BaseResponse{
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'details')
  String details;
  @JsonKey(name: 'services')
  String services;
  @JsonKey(name: 'about')
  String about;
  StoreDataResponse(this.id, this.title,this.image,  this.details, this.services, this.about);

  // to json
  Map<String, dynamic> toJson() => _$StoreDataResponseToJson(this);

  // from json
  factory StoreDataResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDataResponseFromJson(json);
}