import 'package:advance_flutter/data/data_source/local_data_source.dart';
import 'package:advance_flutter/data/data_source/remote_data_source.dart';
import 'package:advance_flutter/data/mapper/mapper.dart';
import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/data/network/network_handler.dart';
import 'package:advance_flutter/data/network/network_info.dart';
import 'package:advance_flutter/data/request/requests.dart';
import 'package:advance_flutter/domain/model/model.dart';
import 'package:advance_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
// check if it's connected to internet, it's safe to call the API
        final response = await _remoteDataSource.login(loginRequest);
          print("ghhhhhhhhhhhhh"+response.contacts.toString());
          print(response.customer);
          print(response.status);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return either right
          // return data
          // save home response to cache
          return Right(response.toDomain());
        } else {
          // failure - return error
          // return either left
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgetPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection erorr
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> registerUser(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
// check if it's connected to internet, it's safe to call the API
        final response = await _remoteDataSource.registerUser(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure - return error
          // return either left
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      // get response from cache
      final response = await _localDataSource.getHomeData();
      print("Response ssssssssssssssssssssssssssss"+response.data.toString());

      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing  or caching is not valid
      // then  get from API
      if (await _networkInfo.isConnected) {
        try {
          // check if it's connected to internet, it's safe to call the API
          final response = await _remoteDataSource.getHomeData();
              print("Response"+response.data.toString());
          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // return either right
            // return data
            // save response in cache  (local data source)
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            // failure - return error
            // return either left

            return left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return internet connection error
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  // @override
  // Future<Either<Failure, StoreDetails>> getStoreDetailsData() {
  // //
  // }
}
