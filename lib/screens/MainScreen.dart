import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/Utils/Utils.dart';
import '../models/AdsUnitId.dart';
import '../cubit/internet_cubit.dart';
import '../Utils/Localization/app_localizations.dart';
import 'CreateScreen.dart';
import 'HistoryScreen.dart';
import 'ScannerScreen.dart';
import 'SettingsScreen.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class MainScreen extends StatefulWidget {
  static QRViewController? controller;
  static showInterstitial() {
    _MainScreenState.showInterstitial();
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool secondBackClick = false;
  //*                                   Ads                                    */

  static final rewardedInterstitial = InterstitialAd(
    unitId: AdsUnitID.InterstitialUnitID,
  )..load();

  static showInterstitial() async {
    if (!rewardedInterstitial.isAvailable) await rewardedInterstitial.load();
    if (rewardedInterstitial.isAvailable) {
      await rewardedInterstitial.show();
      rewardedInterstitial.load(force: true);
    }
  }

  //*                                   Ads                                    */

  late PersistentTabController _pagecontroller;

  @override
  void initState() {
    super.initState();
    _pagecontroller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      ScannerScreen(),
      HistoryScreen(),
      CreateScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.qr_code_scanner_rounded),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: (translate(context, 'scan')),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: (translate(context, 'history')),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.create_outlined),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: (translate(context, 'create')),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings_rounded),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: (translate(context, 'settings')),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _pagecontroller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: (pos) {
          if (MainScreen.controller != null) {
            if (pos == 0) {
              log('resume camera');
              MainScreen.controller!.resumeCamera();
            } else {
              log('pause camera');
              MainScreen.controller!.pauseCamera();
            }
          }
        },
        onWillPop: (_) async {
          if (secondBackClick) {
            SystemNavigator.pop();
          } else {
            secondBackClick = true;
            await Utils.rateApp(context, action: () => SystemNavigator.pop());
          }
          return false;
        },
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).backgroundColor,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Theme.of(context).backgroundColor,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
