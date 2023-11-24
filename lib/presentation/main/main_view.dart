
import 'package:advance_flutter/presentation/main/pages/home_pages.dart';
import 'package:advance_flutter/presentation/main/pages/notification_pages.dart';
import 'package:advance_flutter/presentation/main/pages/search_pages.dart';
import 'package:advance_flutter/presentation/main/pages/settings_pages.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage()
  ];
  List<String> titles = [
    AppStrings.homeScreenTitle,
    AppStrings.searchScreenTitle,
    AppStrings.notificationScreenTitle,
    AppStrings.settingsScreenTitle,
  ];
  var _title = AppStrings.homeScreenTitle;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.grey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.homeScreenTitle),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.searchScreenTitle),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notificationScreenTitle),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settingsScreenTitle),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}