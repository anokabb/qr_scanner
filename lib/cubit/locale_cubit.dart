import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> with HydratedMixin {
  LocaleCubit() : super(LocaleState('en'));

  void toArabic() => emit(LocaleState('ar'));

  void toEnglish() => emit(LocaleState('en'));

  @override
  LocaleState? fromJson(Map<String, dynamic> json) {
    return LocaleState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LocaleState state) {
    return state.toMap();
  }
}
