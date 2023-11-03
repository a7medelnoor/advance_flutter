import 'dart:async';

import 'package:advance_flutter/presentation/resources/assests_manager.dart';
import 'package:advance_flutter/presentation/resources/color_manager.dart';
import 'package:advance_flutter/presentation/resources/constants_manager.dart';
import 'package:advance_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    _appPreferences.isUserLogIn().then((isUserLogIn) => {
     if(isUserLogIn){
    // navigate to the main screen
       // navigate to the route
       Navigator.pushReplacementNamed(context, Routes.mainRoute)
     }else {
       _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) => {
            if(isOnBoardingScreenViewed){
              // navigate to the main
              Navigator.pushReplacementNamed(context, Routes.loginRoute)
            }else {
              // navigate to the onboarding
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)
            }
       })

  }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    // Cancel the timer after finsh
    _timer?.cancel();
    super.dispose();
  }
}
