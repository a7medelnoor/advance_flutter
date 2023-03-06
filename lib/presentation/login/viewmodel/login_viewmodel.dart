import 'dart:async';
import 'dart:math';

import 'package:advance_flutter/domain/usecase/login_use_case.dart';
import 'package:advance_flutter/presentation/base/baseviewmodel.dart';

import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

   var loginObject  = LoginObject("","");
   final LoginUseCase _loginUseCase;
   LoginViewModel(this._loginUseCase);

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
  login()  async{
   (await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName,loginObject.password)))
       .fold((failure) => {
         // left -> Failure
      print(failure.message)
   }, (data) => {
         // right -> data(success)
     print(data.customer?.name)

   });
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
