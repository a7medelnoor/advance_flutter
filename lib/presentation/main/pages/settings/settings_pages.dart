import 'package:advance_flutter/app/app_prefs.dart';
import 'package:advance_flutter/app/di.dart';
import 'package:advance_flutter/data/data_source/local_data_source.dart';
import 'package:advance_flutter/presentation/resources/language_manger.dart';
import 'package:advance_flutter/presentation/resources/strings_manager.dart';
import 'package:advance_flutter/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/assests_manager.dart';
import '../../../resources/routes_manager.dart';

import 'dart:math' as math;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.photoChangeLangIc),
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.photoSettingsRightArrowIc),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.photoContactUsIc),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.photoSettingsRightArrowIc),
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.photoInviteFriendIc),
            title: Text(
              AppStrings.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.photoSettingsRightArrowIc),
            ),
            onTap: () {
              _inviteYourFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.photoLogoutIc),
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.photoSettingsRightArrowIc),
            ),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  bool isRTL() {
    return context.locale == ARABIC_LOCALE;
  }

  _changeLanguage() {
    _appPreferences.changeAppLanguages();
    Phoenix.rebirth(context);
  }

  _contactUs() {}

  _inviteYourFriends() {}

  _logout() {
    // logout remove shared pref
    _appPreferences.logout();
    //clear all cache
    _localDataSource.clearCache();
    // navigate to the home screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
