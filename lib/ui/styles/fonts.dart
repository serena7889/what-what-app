import 'package:flutter/material.dart';

class WWFonts {
  static TextStyle fromOptions(BuildContext context, {double size = 14, WWFontWeight weight = WWFontWeight.regular, required Color color}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight.numberWeight,
      fontFamily: "ProximaNovaAlt",
    );
  }
}

enum WWFontWeight { thin, light, regular, semibold, bold, extraBold, black }

extension WWFontWeightExtension on WWFontWeight {
  FontWeight get numberWeight {
    switch (this) {
      case WWFontWeight.thin:
        return FontWeight.w100;
      case WWFontWeight.light:
        return FontWeight.w300;
      case WWFontWeight.regular:
        return FontWeight.w400;
      case WWFontWeight.semibold:
        return FontWeight.w600;
      case WWFontWeight.bold:
        return FontWeight.w700;
      case WWFontWeight.extraBold:
        return FontWeight.w800;
      case WWFontWeight.black:
        return FontWeight.w900;
    }
  }
}
