import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';

class WWTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;

  const WWTextField({required this.placeholder, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: WWColor.secondaryBackground(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          WWShadow.card.boxShadow(context),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        minLines: 6,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: placeholder,
          labelStyle: WWFonts.fromOptions(context, color: WWColor.primaryText(context), size: 16, weight: WWFontWeight.regular),
          hintStyle: WWFonts.fromOptions(context, color: WWColor.secondaryText(context), size: 16, weight: WWFontWeight.semibold),
        ),
      ),
    );
  }
}
