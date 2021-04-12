part of 'language_cubit.dart';

class LanguageState {
  String languageName;
  LanguageState({
    required this.languageName,
  });

  Map<String, dynamic> toMap() {
    return {
      'languageName': languageName,
    };
  }

  factory LanguageState.fromMap(Map<String, dynamic> map) {
    return LanguageState(
      languageName: map['languageName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageState.fromJson(String source) =>
      LanguageState.fromMap(json.decode(source));
}

// class Language_ARABIC extends LanguageState {
//   String name = 'ar';
// }

// class Language_ENGLISH extends LanguageState {
//   String name = 'ar';
// }

// class Language_FRENCH extends LanguageState {
//   String name = 'ar';
// }
