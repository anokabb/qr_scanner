import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/Utils/Localization/app_localizations.dart';
import 'package:qr_scanner/components/CustomAppBar.dart';
import 'package:qr_scanner/cubit/locale_cubit.dart';
import 'package:qr_scanner/cubit/theme_cubit.dart';

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
          translate(context, 'settings'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingItem(
              title: translate(context, 'theme'),
              onTap: () {
                BlocProvider.of<ThemeCubit>(context).changeTheme();
              },
              child: Row(
                children: [
                  Text(
                    BlocProvider.of<ThemeCubit>(context).state.isDark
                        ? translate(context, 'dark')
                        : translate(context, 'light'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    BlocProvider.of<ThemeCubit>(context).state.isDark
                        ? Icons.nights_stay_rounded
                        : Icons.wb_sunny,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ],
              ),
            ),
            SettingItem(
              title: translate(context, 'language'),
              onTap: () {
                // BlocProvider.of<ThemeCubit>(context).changeTheme();
              },
              child: DropdownButton(
                value: 0,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'en',
                      style: TextStyle(color: Theme.of(context).splashColor),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'ar',
                      style: TextStyle(color: Theme.of(context).splashColor),
                    ),
                    value: 1,
                  ),
                ],
                dropdownColor: Theme.of(context).canvasColor,
                onChanged: (index) {
                  print(index);
                  if (AppLocalizations.of(context).isEnLocale) {
                    BlocProvider.of<LocaleCubit>(context).toArabic();
                  } else {
                    BlocProvider.of<LocaleCubit>(context).toEnglish();
                  }
                },
              ),
            ),
            SettingItem(
              title: translate(context, 'rate_app'),
              onTap: () {},
              child: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_border_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            SettingItem(
              title: translate(context, 'more_apps'),
              onTap: () {},
              child: Icon(
                Icons.apps_rounded,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
            SettingItem(
              title: translate(context, 'share_app'),
              onTap: () {},
              child: Icon(
                Icons.share_rounded,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          ],
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
        spread: BlocProvider.of<ThemeCubit>(context).state.isDark ? 0 : 10,
        depth: 10,
        child: GestureDetector(
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
                    color: Theme.of(context).splashColor,
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
