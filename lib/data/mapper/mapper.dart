import 'package:advance_flutter/app/constants.dart';
import 'package:advance_flutter/app/extensions.dart';
import 'package:advance_flutter/data/response/responses.dart';
import 'package:advance_flutter/domain/model/model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numberOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}
extension StoreDetailsResponseMapper on StoreDataResponse? {
  StoreDetailsModel toDomain() {
    return StoreDetailsModel(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty,
        this?.details.orEmpty() ?? Constants.empty,
        this?.services.orEmpty() ?? Constants.empty,
        this?.about.orEmpty() ?? Constants.empty);
  }
}
extension BannerAdResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
        this?.id.orZero() ?? Constants.zero,
        this?.link.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}
extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
        ?.data
        ?.services
        ?.map((serviceResponse) =>
        serviceResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Service>()
        .toList();

    List<BannerAd> banners = (this
        ?.data
        ?.services
        ?.map((bannerResponse) =>
        bannerResponse.toDomain()) ??
        const Iterable.empty())
        .cast<BannerAd>()
        .toList();


    List<Store> stores = (this
        ?.data
        ?.services
        ?.map((storeResponse) =>
        storeResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Store>()
        .toList();


    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}