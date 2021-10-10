import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WWTheme with ChangeNotifier {
  bool lightMode = true;
  void toggleMode() {
    lightMode = !lightMode;
    notifyListeners();
  }

  ThemeData get themeData {
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primaryColor: WWColor.accentColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: WWColor.accentColor,
        selectionColor: WWColor.accentColor.withOpacity(0.2),
        selectionHandleColor: WWColor.accentColor,
      ),
    );
  }
}

class WWColor {
  static Color primaryText(BuildContext context) => Provider.of<WWTheme>(context).lightMode ? lightPrimaryTextColor : darkPrimaryTextColor;
  static Color secondaryText(BuildContext context) => Provider.of<WWTheme>(context).lightMode ? lightSecondaryTextColor : darkSecondaryTextColor;
  static Color primaryBackground(BuildContext context) => Provider.of<WWTheme>(context).lightMode ? lightPrimaryBackgroundColor : darkPrimaryBackgroundColor;
  static Color secondaryBackground(BuildContext context) => Provider.of<WWTheme>(context).lightMode ? lightSecondaryBackgroundColor : darkSecondaryBackgroundColor;

  static const Color lightPrimaryTextColor = Color(0xff424242);
  static const Color lightSecondaryTextColor = Color(0xff7d879a);
  static const Color lightPrimaryBackgroundColor = Color(0xfff8f8fc);
  static const Color lightSecondaryBackgroundColor = Color(0xffffffff);
  static const Color darkPrimaryTextColor = Color(0xffffffff);
  static const Color darkSecondaryTextColor = Color(0xff8e9195);
  static const Color darkPrimaryBackgroundColor = Color(0xff1f1d29);
  static const Color darkSecondaryBackgroundColor = Color(0xff242734);
  static const Color accentColor = Color(0xff04989d);
  static const Color textOverAccentColor = Color(0xfff8f8fc);
  static const Color positiveAccentColor = Color(0xff6bc7af);
  static const Color negativeAccentColor = Color(0xffca4f4b);
  static const Color clearColor = Color(0xff000000);
}
