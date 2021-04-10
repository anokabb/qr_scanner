import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/QR.dart';

part 'qr_event.dart';

class QrBloc extends Bloc<QrEvent, List<QR>> {
  QrBloc(List<QR> initialState) : super(initialState);

  @override
  Stream<List<QR>> mapEventToState(
    QrEvent event,
  ) async* {
    if (event is SetQrs) {
      yield event.QrList;
    } else if (event is AddQR) {
      List<QR> newState = List.from(state);
      newState.insert(0, event.newQR);
      yield newState;
    } else if (event is DeleteQR) {
      List<QR> newState = List.from(state);
      newState
          .removeAt(newState.indexWhere((element) => element.id == event.id));
      yield newState;
    } else if (event is UpdateQR) {
      List<QR> newState = List.from(state);
      newState[newState.indexWhere((element) => element.id == event.id)] =
          event.newQr;
      yield newState;
    }
  }
}
