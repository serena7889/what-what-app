import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WWCardWrapper extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const WWCardWrapper({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<WWTheme>(
      builder: (context, theme, widget) => MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: WWColor.secondaryBackground(context),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [WWShadow.card.boxShadow(context)],
          ),
          child: child,
        ),
      ),
    );
  }
}
