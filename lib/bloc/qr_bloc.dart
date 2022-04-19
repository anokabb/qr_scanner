import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/QR.dart';

part 'qr_event.dart';

class QrBloc extends Bloc<QrEvent, List<QR>> {
  QrBloc(List<QR> initialState) : super(initialState) {
    on<SetQrs>((event, emit) {
      emit(event.QrList);
    });
  }
}
