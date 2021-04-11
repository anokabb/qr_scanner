import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/cubit/theme_cubit.dart';
import '../db/database_provider.dart';
import '../models/QR.dart';
import '../components/CustomAppBar.dart';
import '../components/txtField.dart';
import 'ResultScreen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen();

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        shape: CustomAppBar(),
        title: Text(
          'Settings',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SettingItem(
                title: 'Theme',
                onTap: () {
                  BlocProvider.of<ThemeCubit>(context).changeTheme();
                },
                child: Row(
                  children: [
                    Text(
                      'Light',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.ac_unit,
                      color: Theme.of(context).accentColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
              SettingItem(
                title: 'Rate App',
                onTap: () {},
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star_border_outlined,
                      color: Theme.of(context).accentColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SettingItem(
                title: 'More Apps',
                onTap: () {},
                child: Icon(
                  Icons.apps_rounded,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
              ),
              SettingItem(
                title: 'Share App',
                onTap: () {},
                child: Icon(
                  Icons.share_rounded,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final Widget child;
  final String title;
  final Function() onTap;
  const SettingItem({
    required this.title,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: ClayContainer(
        color: Theme.of(context).canvasColor,
        borderRadius: 16,
        spread: 10,
        depth: 10,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child
              ],
            ),
          ),
        ),
      ),
    );
  }
}
