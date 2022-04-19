import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/Utils/Utils.dart';
import '../models/AdsUnitId.dart';
import '../Utils/Localization/app_localizations.dart';
import 'CreateScreen.dart';
import 'HistoryScreen.dart';
import 'ScannerScreen.dart';
import 'SettingsScreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainScreen extends StatefulWidget {
  static QRViewController? controller;

  //*                                   Ads                                    */
  static int _adDisplayTimes = 1;
  static InterstitialAd? myInterstitial;

  static void showInterstitial() async {
    if (myInterstitial == null) {
      loadInterstitial();
    } else {
      myInterstitial!.show();
      loadInterstitial();
    }
  }

  static void showInterstitialInterval() async {
    if (_adDisplayTimes % 3 == 0) {
      showInterstitial();
    }
    _adDisplayTimes++;
  }

  static int _failedTimes = 0;

  static void loadInterstitial() {
    log('🔵 loadInterstitial');
    InterstitialAd.load(
        adUnitId: AdsUnitID.InterstitialUnitID,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            myInterstitial = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (_failedTimes < 9) {
              log('🔴 InterstitialAd failed to load: $error');
              loadInterstitial();
              _failedTimes++;
            }
          },
        ));
  }

  //*                                   Ads                                    */

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool secondBackClick = false;

  late PersistentTabController _pagecontroller;

  @override
  void initState() {
    super.initState();
    _pagecontroller = PersistentTabController(initialIndex: 0);
    MainScreen.loadInterstitial();
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
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
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
                await Utils.rateApp(context,
                    action: () => SystemNavigator.pop());
              }
              return false;
            },
            confineInSafeArea: true,
            backgroundColor: Theme.of(context).backgroundColor,
            handleAndroidBackButtonPress: true,
            // Default is true.
            resizeToAvoidBottomInset: true,
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true,
            // Default is true.
            hideNavigationBarWhenKeyboardShows: true,
            // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(0.0),
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
            navBarStyle: NavBarStyle
                .style1, // Choose the nav bar style with this property.
          ),
        ),
      ),
    );
  }
}
