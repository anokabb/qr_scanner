import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with HydratedMixin {
  ThemeCubit()
      : super(ThemeFromSystem(
          isDark: SchedulerBinding.instance!.window.platformBrightness ==
              Brightness.dark,
        ));

  void changeTheme() {
    if (state is ThemeFromSystem) {
      WidgetsBinding.instance!.window.onPlatformBrightnessChanged = null;
      emit(ThemeFromLocal(isDark: false));
    } else {
      if (!state.isDark) {
        WidgetsBinding.instance!.window.onPlatformBrightnessChanged = null;
        emit(ThemeFromLocal(isDark: true));
      } else {
        emit(ThemeFromSystem(
            isDark: SchedulerBinding.instance!.window.platformBrightness ==
                Brightness.dark));
        WidgetsBinding.instance!.window.onPlatformBrightnessChanged = () {
          emit(ThemeFromSystem(
              isDark: SchedulerBinding.instance!.window.platformBrightness ==
                  Brightness.dark));
        };
      }
    }
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
