part of 'qr_bloc.dart';

@immutable
abstract class QrEvent {}

class SetQrs extends QrEvent {
  late List<QR> QrList;

  SetQrs(List<QR> Qrs) {
    QrList = Qrs;
  }
}

class AddQR extends QrEvent {
  late QR newQR;

  AddQR(QR qr) {
    newQR = qr;
  }
}

class DeleteQR extends QrEvent {
  late int id;

  DeleteQR(int index) {
    id = index;
  }
}

class UpdateQR extends QrEvent {
  late QR newQr;
  late int id;

  UpdateQR(int index, QR qr) {
    newQr = qr;
    id = index;
  }
}
