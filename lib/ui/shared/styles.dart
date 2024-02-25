import 'package:flutter/material.dart';
import 'package:sale_inventory/ui/shared/themes.dart';

class Styles {
  static const double fontSizeSmall = 14;
  static const double fontSizeNormal = 18;
  static const double fontSizeLarge = 22;
  static const double fontSizeTitle = 32;
  static const double textHeight = 1.2;

  // Small TextStyle
  static TextStyle _baseTextStyle() =>
      TextStyle(height: textHeight, color: Themes.colorTextOnBackground);
  static TextStyle textStyleSmall() =>
      _baseTextStyle().copyWith(fontSize: fontSizeSmall);
  static TextStyle textStyleSmallBold() =>
      textStyleSmall().copyWith(fontWeight: FontWeight.bold);
  static TextStyle textStyleSmallOnWidget() =>
      textStyleSmall().copyWith(color: Themes.colorTextOnWidget);
  static TextStyle textStyleSmallBoldOnWidget() =>
      textStyleSmallOnWidget().copyWith(fontWeight: FontWeight.bold);

  // Normal TextStyle

  static TextStyle textStyleNormal() =>
      textStyleSmall().copyWith(fontSize: fontSizeNormal);

  static TextStyle textStyleNormalBold() =>
      textStyleNormal().copyWith(fontWeight: FontWeight.bold);

  static TextStyle textStyleNormalOnWidget() =>
      textStyleNormal().copyWith(color: Themes.colorTextOnWidget);

  static TextStyle textStyleNormalBoldOnWidget() =>
      textStyleNormalOnWidget().copyWith(fontWeight: FontWeight.bold);

  // Large TextStyle

  static TextStyle textStyleLarge() =>
      textStyleSmall().copyWith(fontSize: fontSizeLarge);
      
  static TextStyle textStyleLargeBold() =>
      textStyleLarge().copyWith(fontWeight: FontWeight.bold);

  static TextStyle textStyleLargeOnWidget() =>
      textStyleLarge().copyWith(color: Themes.colorTextOnWidget);

  static TextStyle textStyleLargeBoldOnWidget() =>
      textStyleNormalOnWidget().copyWith(fontWeight: FontWeight.bold);

  static const double gridSpacing = 6;

  static const double cornerRadius = 10;
  static const BorderRadius borderRadiusAll =
      BorderRadius.all(Radius.circular(Styles.cornerRadius));
  static const double buttonHeight = 40;
}
