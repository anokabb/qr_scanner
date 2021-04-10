import 'package:flutter/material.dart';
import 'package:qr_scanner/models/QR.dart';

IconData? getIconType(int QrType) {
  switch (QrType) {
    case QR.EMAIL:
      return Icons.email_outlined;
    case QR.URL:
      return Icons.link_rounded;
    case QR.PHONE:
      return Icons.phone_rounded;
    case QR.TEXT:
      return Icons.text_fields_rounded;
    default:
      return null;
  }
}
