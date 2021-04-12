import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../bloc/qr_bloc.dart';
import 'CreateScreen.dart';
import 'HistoryScreen.dart';
import 'ScannerScreen.dart';
import 'SettingsScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
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
        title: ("Scan"),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: ("History"),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.create_outlined),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: ("Create"),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings_rounded),
        activeColorPrimary: Theme.of(context).primaryColor,
        title: ("Settings"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrBloc([]),
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
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
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
