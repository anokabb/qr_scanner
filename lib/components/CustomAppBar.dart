import 'package:flutter/material.dart';

class CustomAppBar extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double extra = 40;

    Path path = Path();
    path.lineTo(0, rect.height + extra);

    path.arcToPoint(Offset(extra, rect.height), radius: Radius.circular(extra));

    path.lineTo(rect.width - extra, rect.height);

    path.arcToPoint(Offset(rect.width, rect.height + extra),
        radius: Radius.circular(extra));

    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
