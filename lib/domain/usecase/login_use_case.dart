
import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/data/request/requests.dart';
import 'package:advance_flutter/domain/repository/repository.dart';
import 'package:advance_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../model/model.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication>{

  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input)  async {
       return await _repository.login(LoginRequest(input.email, input.password));
  }
}
class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}