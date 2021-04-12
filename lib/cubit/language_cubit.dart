import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:qr_scanner/Utils/Translate.dart';
import 'package:qr_scanner/models/Languages.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> with HydratedMixin {
  LanguageCubit() : super(LanguageState(languageName: Languages.ENGLISH_STR)) {
    Translate.instance!.setLanguage(state.languageName);
  }

  void changeLanguage(String lang) => emit(LanguageState(languageName: lang));

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return state.toMap();
  }
}
