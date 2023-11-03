
import 'package:advance_flutter/app/MyApp.dart';
import 'package:advance_flutter/app/di.dart';
import 'package:flutter/material.dart';

void main() async{

  // avoid caching
  WidgetsFlutterBinding.ensureInitialized();

  // initialize app module generic dependencies for the application
  await initAppModule();
  runApp(MyApp());
}

// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs