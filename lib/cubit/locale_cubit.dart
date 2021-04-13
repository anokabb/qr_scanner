import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:qr_scanner/models/Languages.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> with HydratedMixin {
  LocaleCubit() : super(LocaleState(Languages.ENGLISH_STR));

  void toArabic() => emit(LocaleState(Languages.ARABIC_STR));

  void toEnglish() => emit(LocaleState(Languages.ENGLISH_STR));

  void toFrench() => emit(LocaleState(Languages.FRENCH_STR));

  @override
  LocaleState? fromJson(Map<String, dynamic> json) {
    return LocaleState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LocaleState state) {
    return state.toMap();
  }
}
