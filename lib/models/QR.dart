import '../db/database_provider.dart';

class QR {
  int? id;
  String value;
  int? type;
  bool isScanned;

  QR.init({
    this.id,
    required this.value,
    this.type,
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
    );
  }

  @override
  String toString() {
    return 'QR(id: $id, value: $value, type: $type, isScanned: $isScanned)';
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
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value);
  }

  bool _validateURL() {
    return RegExp(
            r"((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)")
        .hasMatch(value);
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
}
