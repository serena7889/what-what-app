import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WWSecondaryButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color backgroundColor;

  final double height = 40;

  WWSecondaryButton({required this.text, required this.onPressed, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Consumer<WWTheme>(
      builder: (context, theme, widget) => MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: [WWShadow.card.boxShadow(context)],
            border: Border.all(color: WWColor.accentColor, width: 2),
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: WWFonts.fromOptions(context, weight: WWFontWeight.bold, color: WWColor.accentColor),
            ),
          ),
        ),
      ),
    );
  }
}
