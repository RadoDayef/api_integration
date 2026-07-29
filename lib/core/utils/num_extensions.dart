import 'package:flutter/cupertino.dart';

extension NumExtensions on num {
  SizedBox get hGap => SizedBox(width: toDouble());

  SizedBox get vGap => SizedBox(height: toDouble());

  SizedBox get sGap => SizedBox(width: toDouble(), height: toDouble());
}
