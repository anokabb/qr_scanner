part of 'locale_cubit.dart';

class LocaleState {
  String langCode;
  int? langId;
  LocaleState(this.langCode) {
    switch (langCode) {
      case Languages.ENGLISH_STR:
        langId = Languages.ENGLISH_id;
        break;
      case Languages.ARABIC_STR:
        langId = Languages.ARABIC_id;
        break;
      case Languages.FRENCH_STR:
        langId = Languages.FRENCH_id;
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'langCode': langCode,
    };
  }

  factory LocaleState.fromMap(Map<String, dynamic> map) {
    return LocaleState(
      map['langCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocaleState.fromJson(String source) =>
      LocaleState.fromMap(json.decode(source));
}

// class SelectedLocale extends LocaleState {
//   SelectedLocale(Locale locale) : super(locale);
// }
