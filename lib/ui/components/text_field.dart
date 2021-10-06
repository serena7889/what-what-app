import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';

enum WWTextFieldStyle { singleLine, multiline }

class WWTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final WWTextFieldStyle style;
  final TextCapitalization capitalization;
  final bool obscure;

  const WWTextField({required this.placeholder, required this.controller, this.style = WWTextFieldStyle.multiline, this.capitalization = TextCapitalization.sentences, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: style == WWTextFieldStyle.singleLine ? 40 : null,
      padding: EdgeInsets.symmetric(vertical: style == WWTextFieldStyle.multiline ? 20 : 0, horizontal: 16),
      decoration: BoxDecoration(
        color: WWColor.secondaryBackground(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          WWShadow.card.boxShadow(context),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: style == WWTextFieldStyle.singleLine ? 1 : null,
        minLines: style == WWTextFieldStyle.multiline ? 6 : null,
        autofocus: true,
        textCapitalization: capitalization,
        obscureText: obscure,
        enableSuggestions: false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeholder,
            labelStyle: WWFonts.fromOptions(context, color: WWColor.primaryText(context), size: 16, weight: WWFontWeight.regular),
            hintStyle: WWFonts.fromOptions(context, color: WWColor.secondaryText(context), size: 16, weight: WWFontWeight.semibold),
            counterStyle: WWFonts.fromOptions(context, color: WWColor.accentColor, size: 16, weight: WWFontWeight.regular)),
      ),
    );
  }
}
