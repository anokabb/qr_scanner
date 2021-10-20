import 'package:flutter/cupertino.dart';
import '../Utils/TimeFormat.dart';
import '../db/database_provider.dart';
import 'package:validated/validated.dart' as validate;

class QR {
  int? id;
  String value;
  int? type;
  bool isScanned;
  int? time;

  QR.init({
    this.id,
    required this.value,
    this.type,
    this.time,
    required this.isScanned,
  });

  QR({
    this.id,
    required this.value,
    required this.isScanned,
  }) {
    this.type = _setType();
  }

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
      DatabaseProvider.COLUMN_DATE: DateTime.now().millisecondsSinceEpoch,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  factory QR.fromMap(Map<String, dynamic> map) {
    return QR.init(
      id: map[DatabaseProvider.COLUMN_ID],
      value: map[DatabaseProvider.COLUMN_VALUE],
      type: map[DatabaseProvider.COLUMN_TYPE],
      isScanned: map[DatabaseProvider.COLUMN_IS_SCANNED] == 1,
      time: map[DatabaseProvider.COLUMN_DATE],
    );
  }

  @override
  String toString() {
    return 'QR(id: $id, value: $value, type: $type, isScanned: $isScanned, time: $time)';
  }

  int _setType() {
    if (_validateEmail()) {
      return EMAIL;
    } else if (_validateURL()) {
      return URL;
    } else if (_validatePhone()) {
      return PHONE;
    } else {
      return TEXT;
    }
  }

  bool _validateEmail() {
    return validate.isEmail(value);
  }

  bool _validateURL() {
    return validate.isURL(value);
  }

  bool _validatePhone() {
    return RegExp(
            r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
        .hasMatch(value);
  }

  String typeToString() {
    switch (type) {
      case TEXT:
        return 'Text';
      case URL:
        return 'URL';
      case PHONE:
        return 'Phone Number';
      case EMAIL:
        return 'E-mail';
      default:
        return '';
    }
  }

  String getTime(BuildContext context, String langCode) {
    return TimeFormat(timestamp: time!, langCode: langCode, context: context)
        .formatTime();
  }
}
