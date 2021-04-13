import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' show json;
import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String>? _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('locales/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map<String, String>((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizedStrings![key]!;

  bool get isEnLocale => locale.languageCode == 'en';
}

String translate(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}
