import 'package:flutter/material.dart';
import 'package:sale_inventory/ui/shared/styles.dart';

class Themes {
  static bool isDarkTheme = false;
  static Color get colorPrimaryLight => const Color(0xFF936BC6);
  static Color get colorPrimaryDark => const Color.fromARGB(255, 85, 0, 141);
  static Color get colorPrimary =>
      isDarkTheme ? colorPrimaryDark : colorPrimaryLight;

  static Color get colorAccent => const Color(0xFF1AA999);

  static Color get _colorBackgroundLight =>
      const Color.fromARGB(255, 230, 230, 230);
  static Color get _colorBackgroundDark => const Color(0xFF1E1E1E);
  static Color get colorBackground =>
      isDarkTheme ? _colorBackgroundDark : _colorBackgroundLight;
  static Color get colorBackgroundInverse =>
      isDarkTheme ? _colorBackgroundLight : _colorBackgroundDark;

  static Color get colorTextLight => const Color(0xFFE8E8E8);
  static Color get colorTextDark => colorPrimary;
  static Color get colorTextOnWidget => colorTextLight;
  static Color get colorTextOnBackground =>
      isDarkTheme ? colorTextLight : colorTextDark;
  static final light = ThemeData(
      useMaterial3: false,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: _createMaterialColor(colorAccent),
      primaryColor: colorPrimaryLight,
      scaffoldBackgroundColor: _colorBackgroundLight,
      canvasColor: _colorBackgroundLight,
      unselectedWidgetColor: colorTextDark,
      colorScheme:
          const ColorScheme.light().copyWith(background: _colorBackgroundLight),
      iconTheme: IconThemeData(color: colorTextDark),
      appBarTheme: AppBarTheme(
        foregroundColor: colorTextLight,
        iconTheme: IconThemeData(color: colorTextLight),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Themes.colorTextOnWidget),
            borderRadius: BorderRadius.circular(Styles.buttonHeight / 2)),
        height: Styles.buttonHeight,
        colorScheme: const ColorScheme.dark(),
        buttonColor: colorAccent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 6, right: 6),
        prefixStyle: Styles.textStyleSmallOnWidget(),
        focusColor: colorTextOnWidget,
        labelStyle: Styles.textStyleSmallOnWidget(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorTextOnWidget),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorTextOnWidget),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorAccent),
        ),
      ),
      dialogTheme: DialogTheme(
          backgroundColor: _colorBackgroundLight,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Themes.colorTextDark),
              borderRadius: Styles.borderRadiusAll)));

  static final dark = light.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: colorPrimaryDark,
      scaffoldBackgroundColor: _colorBackgroundDark,
      canvasColor: _colorBackgroundDark,
      unselectedWidgetColor: colorTextLight,
      colorScheme:
          const ColorScheme.dark().copyWith(background: _colorBackgroundDark),
      iconTheme: IconThemeData(color: colorTextLight),
      dialogTheme: DialogTheme(
          backgroundColor: _colorBackgroundDark,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Themes.colorTextLight),
              borderRadius: Styles.borderRadiusAll)));

  static MaterialColor _createMaterialColor(Color color) {
    final swatches = {
      50: color.withOpacity(.1),
      100: color.withOpacity(.2),
      200: color.withOpacity(.3),
      300: color.withOpacity(.4),
      400: color.withOpacity(.5),
      500: color.withOpacity(.6),
      600: color.withOpacity(.7),
      700: color.withOpacity(.8),
      800: color.withOpacity(.9),
      900: color.withOpacity(1),
    };
    return MaterialColor(color.value, swatches);
  }

  static Decoration get topBarDecoration => BoxDecoration(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      gradient: LinearGradient(
        colors: [Themes.colorPrimary, Themes.colorPrimary.withOpacity(0.7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ));

  static Decoration get bottomBarDecoration => BoxDecoration(
      gradient: LinearGradient(
          colors: [Themes.colorPrimary, Themes.colorPrimary.withOpacity(0.5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));
}
