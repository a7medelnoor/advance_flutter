import 'package:advance_flutter/app/app_prefs.dart';
import 'package:advance_flutter/data/data_source/remote_data_source.dart';
import 'package:advance_flutter/data/network/app.dart';
import 'package:advance_flutter/data/network/dio_factory.dart';
import 'package:advance_flutter/data/network/network_info.dart';
import 'package:advance_flutter/data/repository/repository_impl.dart';
import 'package:advance_flutter/domain/repository/repository.dart';
import 'package:advance_flutter/domain/usecase/login_use_case.dart';
import 'package:advance_flutter/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module it's a module where we put all the generic dependencies

  // create shared pref instance
  final sharedPreferences = await SharedPreferences.getInstance();

  // register to the git it di instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // register to the git it di instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // Remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance<AppServiceClient>()));

  // repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
   // check if the instance is already regi stered or not then register it
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    // login use case instance
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));// login view model instance
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));

  }
}
