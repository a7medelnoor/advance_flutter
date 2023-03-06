import 'dart:async';
import 'dart:math';

import 'package:advance_flutter/presentation/base/baseviewmodel.dart';

import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

   var loginObject  = LoginObject("","");

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject=loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    loginObject=loginObject.copyWith(userName: userName);

  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  // outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUsername;

  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;
}
