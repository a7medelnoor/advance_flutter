import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repository/repository.dart';

class ForgetPasswordUseCase implements BaseUseCase<String, String>{
  final Repository _repository;

  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input)async {
    return await _repository.forgetPassword(input);
  }
}