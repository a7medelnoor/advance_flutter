
import 'package:advance_flutter/app/MyApp.dart';
import 'package:advance_flutter/app/di.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() async{

  // avoid caching
  WidgetsFlutterBinding.ensureInitialized();
// Initialize Dio with logging interceptor
  Dio dio = Dio();
  dio.interceptors.add(LogInterceptor(
    requestHeader: true,
    responseHeader: true,
    responseBody: true,
    requestBody: true,
  ));
  // initialize app module generic dependencies for the application
  await initAppModule();
  runApp(MyApp());
}

// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs