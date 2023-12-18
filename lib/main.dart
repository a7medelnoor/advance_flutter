import 'package:advance_flutter/app/MyApp.dart';
import 'package:advance_flutter/app/di.dart';
import 'package:advance_flutter/presentation/resources/language_manger.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
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
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      child: Phoenix(child: MyApp()),
      supportedLocales: const [ARABIC_LOCALE, ENGLISH_LOCALE],
      path: ASSET_PATH_LOCALISATIONS));
}

// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
