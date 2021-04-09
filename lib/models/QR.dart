import 'dart:convert';

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
      'id': id,
      'value': value,
      'type': type,
      'isScanned': isScanned,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory QR.fromMap(Map<String, dynamic> map) {
    return QR(
      id: map['id'],
      value: map['value'],
      type: map['type'],
      isScanned: map['isScanned'],
    );
  }

  @override
  String toString() {
    return 'QR(id: $id, value: $value, type: $type, isScanned: $isScanned)';
  }
}
