import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WWPrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  final double height = 40;

  WWPrimaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<WWTheme>(
      builder: (context, theme, widget) => MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: WWColor.accentColor,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: [WWShadow.card.boxShadow(context)],
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: WWFonts.fromOptions(
                context,
                weight: WWFontWeight.bold,
                color: WWColor.textOverAccentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
