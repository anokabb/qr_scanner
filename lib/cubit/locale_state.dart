part of 'locale_cubit.dart';

class LocaleState {
  String localeCode;
  LocaleState(this.localeCode);

  Map<String, dynamic> toMap() {
    return {
      'localeCode': localeCode,
    };
  }

  factory LocaleState.fromMap(Map<String, dynamic> map) {
    return LocaleState(
      map['localeCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocaleState.fromJson(String source) =>
      LocaleState.fromMap(json.decode(source));
}

// class SelectedLocale extends LocaleState {
//   SelectedLocale(Locale locale) : super(locale);
// }
