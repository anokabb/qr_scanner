import 'package:flutter/services.dart';
import 'package:qr_scanner/models/Languages.dart';
import 'package:yaml/yaml.dart';

class Translate {
  static Translate? instance = Translate._internal();

  Translate._internal();

  YamlMap? currentLanguage;
  setLanguage(String language) async {
    if (language == '') {
      language = Languages.ENGLISH_STR;
    }

    Languages.Current_LANG = language;
    String yamlContent = await rootBundle.loadString("locales/$language.yaml");
    currentLanguage = loadYaml(yamlContent);
  }

  String translate(String key) {
    if (currentLanguage == null) {
      setLanguage(Languages.ENGLISH_STR);
    }
    if (!currentLanguage!.keys.contains(key)) {
      return key;
    }
    return currentLanguage![key];
  }
}

String translate(String key) {
  return Translate.instance!.translate(key);
}
