import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/Localization/app_localizations.dart';
import '../components/CustomAppBar.dart';
import '../cubit/locale_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../models/Languages.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                SettingItem(
                  title: translate(context, 'theme'),
                  onTap: () {
                    BlocProvider.of<ThemeCubit>(context).changeTheme();
                  },
                  child: Row(
                    children: [
                      Text(
                        BlocProvider.of<ThemeCubit>(context).state
                                is ThemeFromSystem
                            ? translate(context, 'auto')
                            : BlocProvider.of<ThemeCubit>(context).state.isDark
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
                        BlocProvider.of<ThemeCubit>(context).state
                                is ThemeFromSystem
                            ? Icons.brightness_auto_rounded
                            : BlocProvider.of<ThemeCubit>(context).state.isDark
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
                  onTap: () {},
                  child: DropdownButton(
                    underline: Container(),
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          translate(context, 'english'),
                          style:
                              TextStyle(color: Theme.of(context).splashColor),
                        ),
                        value: Languages.ENGLISH_id,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          translate(context, 'french'),
                          style:
                              TextStyle(color: Theme.of(context).splashColor),
                        ),
                        value: Languages.FRENCH_id,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          translate(context, 'arabic'),
                          style:
                              TextStyle(color: Theme.of(context).splashColor),
                        ),
                        value: Languages.ARABIC_id,
                      ),
                    ],
                    onChanged: (index) {
                      if (index == Languages.ENGLISH_id) {
                        BlocProvider.of<LocaleCubit>(context).toEnglish();
                      } else if (index == Languages.FRENCH_id) {
                        BlocProvider.of<LocaleCubit>(context).toFrench();
                      } else if (index == Languages.ARABIC_id) {
                        BlocProvider.of<LocaleCubit>(context).toArabic();
                      }
                    },
                    value: BlocProvider.of<LocaleCubit>(context).state.langId,
                    dropdownColor: Theme.of(context).canvasColor,
                  ),
                ),
                SettingItem(
                  title: translate(context, 'rate_app'),
                  onTap: () async {
                    launch(
                        "https://play.google.com/store/apps/details?id=com.akdev.qrscanner");
                  },
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
                  onTap: () {
                    launch(
                        "https://play.google.com/store/apps/developer?id=AK.Dev");
                  },
                  child: Icon(
                    Icons.apps_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                SettingItem(
                  title: translate(context, 'share_app'),
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=' +
                            "com.akdev.qrscanner");
                  },
                  child: Icon(
                    Icons.share_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          // MyBanner()
        ],
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
        height: 70,
        color: Theme.of(context).canvasColor,
        borderRadius: 16,
        spread: BlocProvider.of<ThemeCubit>(context).state.isDark ? 0 : 10,
        depth: 10,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).splashColor,
                      fontWeight: FontWeight.bold,
                    ),
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
