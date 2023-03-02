import 'package:advance_flutter/data/data_source/remote_data_source.dart';
import 'package:advance_flutter/data/mapper/mapper.dart';
import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/data/network/network_info.dart';
import 'package:advance_flutter/data/request/requests.dart';
import 'package:advance_flutter/domain/model/model.dart';
import 'package:advance_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // check if it's connected to internet, it's safe to call the API
      final response = await _remoteDataSource.login(loginRequest);

      if (response.status == 0) {
        // success
        // return either right
        // return data
        return Right(response.toDomain());
      } else {
        // failure - return error
        // return either left
        return left(Failure(409, response.message ?? "Business error message"));
      }
    } else {
      // return internet connection error
      return left(Failure(409, "Please check you internet connection"));
    }
  }
}
