part of 'qr_bloc.dart';

@immutable
abstract class QrEvent {}

class SetQrs extends QrEvent {
  late List<QR> QrList;

  SetQrs(List<QR> Qrs) {
    QrList = Qrs;
  }
}
