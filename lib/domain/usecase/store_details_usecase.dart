import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/response/responses.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<void, StoreDataResponse>{

  final Repository _repository;
  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDataResponse>> execute(void input) async {
    return await _repository.getStoreDetailsData();

  }

}
