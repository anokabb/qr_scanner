import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryScanned());

  void scannedHistory() => emit(HistoryScanned());

  void createdHistory() => emit(HistoryCreated());
}
