part of 'theme_cubit.dart';

class ThemeState {
  bool isDark;
  ThemeState({
    required this.isDark,
  });

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
}
