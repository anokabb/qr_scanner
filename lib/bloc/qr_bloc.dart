import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(QrInitial());

  @override
  Stream<QrState> mapEventToState(
    QrEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
