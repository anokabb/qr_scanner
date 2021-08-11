part of 'theme_cubit.dart';

class ThemeState {
  bool isDark;
  bool systemTheme = true;

  ThemeState({required this.isDark});

  Map<String, dynamic> toMap() {
    return {
      'isDark': isDark,
      'systemTheme': this is ThemeFromSystem,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    if (map['systemTheme']) {
      return ThemeState(
        isDark: SchedulerBinding.instance!.window.platformBrightness ==
            Brightness.dark,
      );
    } else {
      return ThemeState(isDark: map['isDark']);
    }
  }
}

class ThemeFromSystem extends ThemeState {
  bool isDark;

  ThemeFromSystem({required this.isDark}) : super(isDark: isDark);
}

class ThemeFromLocal extends ThemeState {
  bool isDark;

  ThemeFromLocal({required this.isDark}) : super(isDark: isDark);
}
