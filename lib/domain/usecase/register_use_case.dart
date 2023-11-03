
import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/data/request/requests.dart';
import 'package:advance_flutter/domain/repository/repository.dart';
import 'package:advance_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../model/model.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authentication>{

  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input)  async {
       return await _repository.registerUser(RegisterRequest(input.email, input.password, input.userName, input.countryMobileCode,input.countryMobileCode,input.mobileNumber));
  }
}
class RegisterUseCaseInput {
  String userName;
  String password;
  String countryMobileCode;
  String mobileNumber;
  String profilePicture;
  String email;

  RegisterUseCaseInput(this.userName, this.password, this.countryMobileCode,
      this.mobileNumber, this.profilePicture, this.email);
}