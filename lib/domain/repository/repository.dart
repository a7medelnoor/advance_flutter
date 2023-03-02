
import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/data/request/requests.dart';
import '../model/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
   Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}