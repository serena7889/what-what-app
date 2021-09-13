import 'package:what_what_app/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum WWShadow { card }

extension WWShadowExtension on WWShadow {
  BoxShadow boxShadow(BuildContext context) {
    bool lightMode = Provider.of<WWTheme>(context).lightMode;
    switch (this) {
      case WWShadow.card:
        return lightMode ? lightCardShadow : darkCardShadow;
    }
  }

  static BoxShadow lightCardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(0, 4),
    blurRadius: 16,
    spreadRadius: 0,
  );

  static BoxShadow darkCardShadow = BoxShadow(
    color: Colors.white.withOpacity(0.24),
    offset: Offset(0, 1),
    blurRadius: 8,
    spreadRadius: 0,
  );
}
