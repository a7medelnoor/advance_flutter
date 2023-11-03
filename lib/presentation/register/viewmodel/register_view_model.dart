
import 'dart:async';
import 'dart:io';

import 'package:advance_flutter/domain/usecase/register_use_case.dart';
import 'package:advance_flutter/presentation/base/baseviewmodel.dart';
import 'package:advance_flutter/presentation/resources/strings_manager.dart';

import '../../../app/functions.dart';
import '../../common/freezed_data_classes.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController mobileNumberStreamController =
  StreamController<String>.broadcast();
  StreamController emailStreamController =
  StreamController<String>.broadcast();
  StreamController passwordStreamController =
  StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
  StreamController<File>.broadcast();
  StreamController areAllInputValidStreamController =
  StreamController<void>.broadcast();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("","","","","","","");
  RegisterViewModel(this._registerUseCase);

 // input
  @override
  // TODO: implement inputEmail
  Sink get inputEmail => emailStreamController.sink;

  @override
  // TODO: implement inputMobileNumber
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => passwordStreamController.sink;

  @override
  // TODO: implement inputProfilePicture
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => userNameStreamController.sink;


  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  setCountryCode(String countryCode) {
    // validate the user name
    if(countryCode.isNotEmpty){
      // update
      registerObject = registerObject.copyWith(countryMobileCode:countryCode);
    }else {
      // reset username
      registerObject = registerObject.copyWith(countryMobileCode:"");

    }
  }

  @override
  setEmail(String email) {
    // validate the user name
    if(isEmailValid(email)){
      // update
      registerObject = registerObject.copyWith(email:email);
    }else {
      // reset username
      registerObject = registerObject.copyWith(email:"");

    }
  }

  @override
  setMobileNumber(String mobile) {
    // validate the user name
    if( _isMobileNumberValid(mobile)){
      // update
      registerObject = registerObject.copyWith(mobileNumber:mobile);
    }else {
      // reset username
      registerObject = registerObject.copyWith(mobileNumber:"");

    }
  }

  @override
  setPassword(String password) {
    if(_isPasswordValid(password)){
      // update
      registerObject = registerObject.copyWith(password:password);
    }else {
      // reset username
      registerObject = registerObject.copyWith(password:"");

    }
  }

  @override
  setUserName(String userName) {
    // validate the user name
    if(_isUserNameValid(userName)){
       // update
      registerObject = registerObject.copyWith(userName:userName);
    }else {
      // reset username
      registerObject = registerObject.copyWith(userName:"");

    }
  }

  @override
  setUserProfile(File profile
      ) {
    // validate the user name
    if(profile.path.isNotEmpty){
      // update
      registerObject = registerObject.copyWith(profilePicture:profile.path);
    }else {
      // reset username
      registerObject = registerObject.copyWith(profilePicture:"");

    }
  }

  @override
  void start() {

  }
  // output
  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map((isUserName) =>
  isUserName ? null : AppStrings.usernameInvalid);

  @override
  Stream<bool> get outputIsEmailValid =>emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((isEmailValid) =>
  isEmailValid ? null : AppStrings.emailInvalid);

  @override
  Stream<bool> get outputIsMobileNumberValid => mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map((isMobileNumberValid) =>
  isMobileNumberValid ? null : AppStrings.mobileNumberInvalid);

  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map((isPasswordValid) =>
  isPasswordValid ? null : AppStrings.passwordNumberInvalid);

  @override
  Stream<File> get outputIsProfilePictureValid => profilePictureStreamController.stream.map((file) => file);

  bool _isUserNameValid(String userName){
return userName.length >= 8;
  }
   bool _isMobileNumberValid(String mobileNumber) {

    return mobileNumber.length >= 10;
  }
  bool _isPasswordValid(String password) {

    return password.length >= 6;
  }
  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputValidStreamController.close();

    super.dispose();
  }



}


abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputMobileNumber;
  Sink get inputProfilePicture;
  register();
  setUserName(String userName);
  setEmail(String email);
  setMobileNumber(String mobile);
  setPassword(String password);
  setUserProfile(File profile);
  setCountryCode(String countryCode);
}
abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<File> get outputIsProfilePictureValid;

}