part of 'theme_cubit.dart';

class ThemeState {
  bool isDark;
  ThemeState({
    required this.isDark,
  });
  ThemeData lightThemeData = ThemeData(
    primaryColor: Color.fromRGBO(98, 0, 238, 1),
    accentColor: Color.fromRGBO(98, 0, 238, 1),
    backgroundColor: Colors.white,
    canvasColor: Color(0xFFF2F2F2),
  );
  ThemeData darkThemeData = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.white,
    backgroundColor: Colors.black,
    canvasColor: Color(0xFFF2F2F2),
  );

  ThemeData getTheme() {
    return isDark ? darkThemeData : lightThemeData;
  }

  Map<String, dynamic> toMap() {
    return {
      'isDark': isDark,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      isDark: map['isDark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeState.fromJson(String source) =>
      ThemeState.fromMap(json.decode(source));
}
