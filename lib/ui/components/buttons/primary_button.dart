import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum WWPrimaryButtonState { active, loading, disabled }

class WWPrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final WWPrimaryButtonState state;

  final double height = 40;

  WWPrimaryButton({required this.text, required this.onPressed, this.state = WWPrimaryButtonState.active});

  String get buttonText {
    switch (state) {
      case WWPrimaryButtonState.loading:
        return "Loading";
      default:
        return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WWTheme>(
      builder: (context, theme, widget) => MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: state == WWPrimaryButtonState.active ? onPressed : null,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: WWColor.accentColor.withOpacity(state == WWPrimaryButtonState.disabled ? 0.4 : 1),
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: [WWShadow.card.boxShadow(context)],
          ),
          child: Center(
            child: Text(
              buttonText.toUpperCase(),
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
