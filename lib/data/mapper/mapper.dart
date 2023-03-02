import 'package:advance_flutter/app/constants.dart';
import 'package:advance_flutter/app/extensions.dart';
import 'package:advance_flutter/data/response/responses.dart';
import 'package:advance_flutter/domain/model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain(){
    return Customer(this?.id.orEmpty() ?? Constants.empty,
         this?.name.orEmpty() ?? Constants.empty,
        this?.numberOfNotifications.orZero() ?? Constants.zero);
  }
}
extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain(){
    return Contacts(this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain(){
    return Authentication(
        this?.customer.toDomain(),
        this?.contacts.toDomain()
    );
  }
}