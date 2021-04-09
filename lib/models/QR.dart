import 'package:qr_scanner/db/database_provider.dart';

class QR {
  int? id;
  String value;
  int type;
  bool isScanned;
  QR({
    this.id,
    required this.value,
    required this.type,
    required this.isScanned,
  });

  /*! QR TYPES !*/
  static const TEXT = 0;
  static const URL = 1;
  static const PHONE = 2;
  static const EMAIL = 3;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_VALUE: value,
      DatabaseProvider.COLUMN_TYPE: type,
      DatabaseProvider.COLUMN_IS_SCANNED: isScanned ? 1 : 0,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  factory QR.fromMap(Map<String, dynamic> map) {
    return QR(
      id: map[DatabaseProvider.COLUMN_ID],
      value: map[DatabaseProvider.COLUMN_VALUE],
      type: map[DatabaseProvider.COLUMN_TYPE],
      isScanned: map[DatabaseProvider.COLUMN_IS_SCANNED] == 1,
    );
  }

  @override
  String toString() {
    return 'QR(id: $id, value: $value, type: $type, isScanned: $isScanned)';
  }

  String typeToString() {
    switch (type) {
      case TEXT:
        return 'Text';
      case URL:
        return 'Link';
      case PHONE:
        return 'Phone Number';
      case EMAIL:
        return 'E-mail';
      default:
        return '';
    }
  }
}
