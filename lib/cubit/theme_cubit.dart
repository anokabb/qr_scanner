import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with HydratedMixin {
  ThemeCubit() : super(ThemeState(isDark: true));

  void changeTheme() => emit(ThemeState(isDark: !state.isDark));

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
